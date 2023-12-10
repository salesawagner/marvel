//
//  GetComicResponse.swift
//  Marvel
//
//  Created by Wagner Sales on 07/12/23.
//

import Foundation

struct GetComicResponse: Decodable {
    let id: Int
    let title: String?
    let textObjects: [TextObjects]
    let images: [Image]
}

struct TextObjects: Decodable {
    let type: String
    let language: String
    let text: String
}
