//
//  Environment.swift
//  Marvel
//
//  Created by Wagner Sales on 07/12/23.
//

import API

class Environment: APIEnvironment {
    var apipublicKey: String
    var apiprivateKey: String
    var domainURL: URL?
    var type: API.APIEnvironmentType

    init(apipublicKey: String, apiprivateKey: String, domainURL: URL? = nil, type: API.APIEnvironmentType) {
        self.apipublicKey = apipublicKey
        self.apiprivateKey = apiprivateKey
        self.domainURL = domainURL
        self.type = type
    }

    static var production = Environment( // Obfuscation would be necessary
        apipublicKey: "9d031e3b858d70cb0f76a5efce634e61",
        apiprivateKey: "5e96c9810158f55b11a323b658a972312995d4a8",
        domainURL: URL(string: "https://gateway.marvel.com/v1/public/"),
        type: .production
    )

    static var local = Environment(
        apipublicKey: "",
        apiprivateKey: "",
        domainURL: URL(string: ""),
        type: .local
    )
}
