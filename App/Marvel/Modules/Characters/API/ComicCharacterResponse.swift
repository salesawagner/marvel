//
//  ComicCharacterResponse.swift
//  Marvel
//
//  Created by Wagner Sales on 07/12/23.
//

import API

struct ComicResponse: Decodable {
    let available: Int
    let collectionURI: String
    let items: [ComicItems]
}

struct ComicItems: Decodable {
    let resourceURI: String
    let name: String
}

struct ComicCharacterResponse: Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Image?
    let comics: ComicResponse
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
