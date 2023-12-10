//
//  GetCharactersRequest.swift
//  Marvel
//
//  Created by Wagner Sales on 07/12/23.
//

import API

struct GetCharactersRequest: APIRequest {
    typealias Response = [ComicCharacterResponse]

    var httpMethod: APIHTTPMethod {
        .get
    }

    var resourceName: String {
        return "characters"
    }

    // Parameters
    let name: String?
    let nameStartsWith: String?
    let limit: Int?
    let offset: Int?

    init(name: String? = nil, nameStartsWith: String? = nil,  limit: Int? = nil, offset: Int? = nil) {
        self.name = name
        self.nameStartsWith = nameStartsWith
        self.limit = limit
        self.offset = offset
    }
}
