//
//  APIClient.swift
//  API
//
//  Created by Wagner Sales on 05/12/23.
//

import Foundation

public class WASAPI: APIClient {
    // MARK: Private Properties

    private var environment: APIEnvironment
    private let session = URLSession(configuration: .default)

    // MARK: Inits

    public init(environment: APIEnvironment) {
        self.environment = environment
    }

    // MARK: Private Methods

    private func endpoint<T: APIRequest>(for request: T) -> URL? {
        guard environment.type != .local else {
            let classType = type(of: request)
            let fileName = String(describing: classType)
            let bundle = Bundle(for: WASAPI.self)
            return bundle.getUrlFile(named: fileName)
        }

        guard
            let domainURL = environment.domainURL,
            let endpoint = URL(string: request.resourceName, relativeTo: domainURL),
            var components = URLComponents(url: endpoint, resolvingAgainstBaseURL: true) else {
            APILogger.mark("Bad resourceName: \(request.resourceName)")
            return nil
        }

        // Common query items needed for all Marvel requests
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = "\(timestamp)\(environment.apiprivateKey)\(environment.apipublicKey)".md5
        var customQueryItems = [
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "apikey", value: environment.apipublicKey)
        ]

        switch request.httpMethod {
        case .get:
            do {
                let queryItems = try URLQueryItemEncoder.encode(request)
                customQueryItems.append(contentsOf: queryItems)
            } catch {
                APILogger.mark("Wrong parameters: \(error)")
                return nil
            }

            components.queryItems = customQueryItems
            return components.url
        
        default:
            return components.url
        }
    }

    private func prepareRequest<R: APIRequest>(_ request: R, endpoint: URL) -> URLRequest {
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = request.httpMethod.rawValue

        if request.httpMethod != .get {
            do {
                let parameters = try JSONEncoder().encode(request)
                urlRequest.httpBody = parameters
            } catch let error {
                APILogger.mark(error.localizedDescription)
            }
        }

        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.logger(.verbose)

        return urlRequest
    }

    private func dataTask(urlRequest: URLRequest, completion: @escaping ResultCallback<(Data?, URLResponse?)>) {
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                APILogger.mark("invalidResponse")
                completion(.failure(APIError.invalidResponse))

                return
            }

            if let error = error {
                APILogger.mark("unknown: \(error) \(httpResponse.statusCode)")
                completion(.failure(.unknown(error: error, statusCode: httpResponse.statusCode)))
            } else {
                completion(.success((data, response)))
            }
        }

        task.resume()
    }

    private func parse<R: APIRequest>(
        _ request: R,
        data: Data?,
        response: URLResponse?,
        completion: @escaping ResultCallback<R.Response>
    ) {
        if let httpResponse = response as? HTTPURLResponse {
            httpResponse.logger(data: data, level: .verbose)
        }

        guard let data = data else {
            completion(.failure(APIError.invalidResponse))
            return
        }

        do {
            let response = try JSONDecoder().decode(MarvelResponse<R.Response>.self, from: data)

            if let dataContainer = response.data {
                completion(.success(dataContainer.results))
            } else if let message = response.message {
                completion(.failure(APIError.server(message: message)))
            } else {
                completion(.failure(APIError.decoding))
            }

        } catch {
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            completion(.failure(.unknown(error: error, statusCode: statusCode ?? 404)))
        }
    }

    // MARK: Internal Properties

    public func send<T>(_ request: T, completion: @escaping ResultCallback<T.Response>) where T : APIRequest {
        guard let endpoint = endpoint(for: request) else {
            completion(.failure(APIError.badUrl))
            return
        }

        APILogger.log(.init(message: endpoint.absoluteString, attributes: request.attributes))
        let urlRequest = prepareRequest(request, endpoint: endpoint)
        let task = session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else {
                    APILogger.mark("invalidResponse")
                    completion(.failure(APIError.invalidResponse))
                    return
                }
                
                if let error = error {
                    APILogger.mark("unknown: \(error) \(httpResponse.statusCode)")
                    completion(.failure(.unknown(error: error, statusCode: httpResponse.statusCode)))
                } else {
                    self?.parse(request, data: data, response: response, completion: completion)
                }
            }
        }

        task.resume()
    }
}
