//
//  CharacterRowViewModelMock.swift
//  MarvelTests
//
//  Created by Wagner Sales on 10/12/23.
//

import Foundation
@testable import Marvel

extension CharacterRowViewModel {
    static var mock: CharacterRowViewModel {
        .init(name: "", resourceURI: "")
    }
}

extension Array where Element == CharacterRowViewModel {
    static var mock: [CharacterRowViewModel] {
        [.mock]
    }
}
