//
//  APITests.swift
//  APITests
//
//  Created by Wagner Sales on 05/12/23.
//

import XCTest
import API

final class APITests: XCTestCase {
    func testExample() throws {
        let expectation = XCTestExpectation(description: "testNotConfigured")
        let api = WASAPI(environment: Environment.local)
        api.send(GetCharactersRequest()) { result in
            switch result {
            case .success(let response):
                print(response)
                XCTAssertGreaterThan(response.count, 0)

            case .failure:
                XCTFail()

            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }
}

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

    static var local = Environment(
        apipublicKey: "",
        apiprivateKey: "",
        domainURL: URL(string: ""),
        type: .local
    )
}

struct GetCharactersRequest: APIRequest {
    typealias Response = [GetComicRequest]

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

    init(name: String? = nil, nameStartsWith: String? = nil, limit: Int? = nil, offset: Int? = nil) {
        self.name = name
        self.nameStartsWith = nameStartsWith
        self.limit = limit
        self.offset = offset
    }
}

struct GetComicRequest: Decodable {
    let id: Int
    let name: String?
    let description: String?
    let thumbnail: Image?
}

struct Image: Decodable {
    enum ImageKeys: String, CodingKey {
        case path = "path"
        case fileExtension = "extension"
    }

    let url: URL

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ImageKeys.self)
        let path = try container.decode(String.self, forKey: .path)
        let fileExtension = try container.decode(String.self, forKey: .fileExtension)

        guard let url = URL(string: "\(path).\(fileExtension)") else { throw APIError.decoding }
        self.url = url
    }
}
