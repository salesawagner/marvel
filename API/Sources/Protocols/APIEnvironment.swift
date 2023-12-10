//
//  APIEnvironment.swift
//  API
//
//  Created by Wagner Sales on 06/12/23.
//

import Foundation

public protocol APIEnvironment {
    var apipublicKey: String { get }
    var apiprivateKey: String { get }
    var domainURL: URL? { get }
    var type: APIEnvironmentType { get }
}
