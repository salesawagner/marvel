//
//  APILoggerDTO.swift
//  API
//
//  Created by Wagner Sales on 06/12/23.
//

import Foundation

struct APILoggerDTO {
    let message: String
    let error: Error?
    let attributes: [String: String]?

    init(message: String, error: Error? = nil, attributes: [String: String]? = nil) {
        self.message = message
        self.error = error
        self.attributes = attributes
    }
}
