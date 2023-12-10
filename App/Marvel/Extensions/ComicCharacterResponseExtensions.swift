//
//  ComicCharacterResponseExtensions.swift
//  Marvel
//
//  Created by Wagner Sales on 07/12/23.
//

import Foundation

extension Array where Element == ComicCharacterResponse {
    var sectionViewModel: [CharacterSectionViewModel] {
        map {
            .init(name: $0.name ?? "", thumbnailURL: $0.thumbnail?.url, rows: $0.comics.rowViewModel)
        }
    }
}
