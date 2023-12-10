//
//  ComicResponseExtensions.swift
//  Marvel
//
//  Created by Wagner Sales on 07/12/23.
//

import Foundation

extension ComicResponse {
    var rowViewModel: [CharacterRowViewModel] {
        items.map { .init(name: $0.name ?? "", resourceURI: $0.resourceURI ?? "") }
    }
}
