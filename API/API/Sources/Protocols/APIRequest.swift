//
//  APIRequest.swift
//  API
//
//  Created by Wagner Sales on 05/12/23.
//

import Foundation

public protocol APIRequest: Encodable {
    associatedtype Response: Decodable

    var httpMethod: APIHTTPMethod { get }
    var resourceName: String { get }
}

extension APIRequest {
    var attributes: [String: String] {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return [:]
        }

        return dictionary.mapValues { String(describing: $0) }
    }
}
