//
//  GetComicRequest.swift
//  Marvel
//
//  Created by Wagner Sales on 07/12/23.
//

import API

struct GetComicRequest: APIRequest {
    typealias Response = [GetComicResponse]

    var httpMethod: APIHTTPMethod {
        .get
    }

    var resourceName: String

    init(resourceName: String) {
        self.resourceName = resourceName
    }
}
