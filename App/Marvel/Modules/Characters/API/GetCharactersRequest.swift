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
    let nameStartsWith: String?

    init(nameStartsWith: String? = nil) {
        self.nameStartsWith = nameStartsWith
    }
}
