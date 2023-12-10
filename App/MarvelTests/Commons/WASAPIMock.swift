//
//  WASAPIMock.swift
//  MarvelTests
//
//  Created by Wagner Sales on 10/12/23.
//

import Foundation
import API

final class WASAPIMock: APIClient {
    func send<T>(_ request: T, completion: @escaping ResultCallback<T.Response>) where T : APIRequest {
        completion(.failure(.invalidParam))
    }
}
