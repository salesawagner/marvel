//
//  MarvelError.swift
//  API
//
//  Created by Wagner Sales on 05/12/23.
//

import Foundation

public enum APIError: Error {
    case badUrl
    case decoding
    case unknown(error: Error, statusCode: Int)
    case invalidParam
    case invalidResponse
    case statusCode(_ code: Int)
    case server(message: String)
}
