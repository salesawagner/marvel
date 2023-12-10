//
//  APIClient.swift
//  API
//
//  Created by Wagner Sales on 05/12/23.
//

import Foundation

public typealias ResultCallback<Value> = (Result<Value, APIError>) -> Void
public protocol APIClient {
    func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>)
}
