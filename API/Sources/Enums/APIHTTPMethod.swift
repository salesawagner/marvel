//
//  HTTPMethod.swift
//  API
//
//  Created by Wagner Sales on 05/12/23.
//

import Foundation

public enum APIHTTPMethod: String {
    case options = "OPTIONS"
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case trace = "TRACE"
    case connect = "CONNECT"
}
