//
//  CharacterSectionViewModelMock.swift
//  MarvelTests
//
//  Created by Wagner Sales on 10/12/23.
//

import Foundation
@testable import Marvel

extension CharacterSectionViewModel {
    static var mock: CharacterSectionViewModel {
        .init(name: "", thumbnailURL: URL(string: ""), rows: [])
    }
}

extension Array where Element == CharacterSectionViewModel {
    static var mock: [CharacterSectionViewModel] {
        [.mock]
    }
}
