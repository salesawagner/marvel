//
//  APITests.swift
//  APITests
//
//  Created by Wagner Sales on 05/12/23.
//

import XCTest
import API

final class APITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {

        let expectation = XCTestExpectation(description: "testNotConfigured")
        let api = WASAPI(environment: Environment.production)
        api.send(GetCharacters()) { result in
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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

// FIXME: remove
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

    static var production = Environment(
        apipublicKey: "9d031e3b858d70cb0f76a5efce634e61",
        apiprivateKey: "5e96c9810158f55b11a323b658a972312995d4a8",
        domainURL: URL(string: "https://gateway.marvel.com:443/v1/public/"),
        type: .production
    )
}

struct GetCharacters: APIRequest {
    typealias Response = [ComicCharacter]

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

struct ComicCharacter: Decodable {
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
