//
//  URLQueryItemEncoder.swift
//  API
//
//  Created by Wagner Sales on 06/12/23.
//

import Foundation

enum URLQueryItemEncoder {
    static func encode<T: Encodable>(_ encodable: T) throws -> [URLQueryItem] {
        let parametersData = try JSONEncoder().encode(encodable)
        let parameters = try JSONDecoder().decode([String: HTTPParameter].self, from: parametersData)
        return parameters.map { URLQueryItem(name: $0, value: $1.description) }
    }

    static func encodeWithSlash<T: Encodable>(_ encodable: T) throws -> String {
        let parametersData = try JSONEncoder().encode(encodable)
        let parameters = try JSONDecoder().decode([String: HTTPParameter].self, from: parametersData)

        var path = ""
        parameters.forEach { path += "/" + $1.description }

        return path
    }
}
