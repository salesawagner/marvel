//
//  URLRequestExtensions.swift
//  API
//
//  Created by Wagner Sales on 06/12/23.
//

import Foundation

enum LogLevel {
    case simple
    case verbose
}

extension URLRequest {
    @discardableResult
    func logger(_ level: LogLevel = .simple) -> Self {
        APILogger.mark(">> Request \(self.httpMethod ?? "") - \(self.url?.absoluteString ?? "")")

        guard level == .verbose else {
            return self
        }

        APILogger.clean("curl -k")

        if let method = self.httpMethod {
            APILogger.clean("-X \(method)")
        }

        if let headers = self.allHTTPHeaderFields {
            for (header, value) in headers {
                APILogger.clean("-H \"\(header): \(value)\"")
            }
        }

        if
            let body = self.httpBody, !body.isEmpty,
            let string = String(data: body, encoding: .utf8), !string.isEmpty {
            APILogger.clean("-d '\(string)'")
        }

        if let url = self.url {
            APILogger.clean(url.absoluteString)
        }

        APILogger.ln()
        return self
    }
}

extension HTTPURLResponse {
    @discardableResult
    func logger(data: Data? = nil, error: Error? = nil, level: LogLevel = .simple) -> HTTPURLResponse {
        let urlString = self.url?.absoluteString ?? ""
        APILogger.mark(">> Response \(urlString)")

        guard let components = NSURLComponents(string: urlString) else {
            return self
        }

        APILogger.clean("HTTP \(self.statusCode) \((components.path ?? ""))?\(components.query ?? "")")
        APILogger.clean("Host: \(components.host ?? "")")

        guard level == .verbose else {
            return self
        }

        for (key, value) in self.allHeaderFields {
            APILogger.clean("\(key): \(value)")
        }

        if let body = data {
            APILogger.clean("\nBody:\(body.string)\n")
        }

        if let error = error {
            APILogger.clean("\nError: \(error.localizedDescription)\n")
        }

        APILogger.ln()
        return self
    }
}
