//
//  CharactersViewModelSpy.swift
//  MarvelTests
//
//  Created by Wagner Sales on 10/12/23.
//

import Foundation
@testable import Marvel

final class CharactersViewModelSpy: CharactersInputProtocol {
    var receivedMessages: [Message] = []

    var viewController: CharactersOutputProtocol?
    var sections: [CharacterSectionViewModel] = []

    func viewDidLoad() {
        receivedMessages.append(.viewDidLoad)
    }

    func requestCharacters(nameStartsWith: String?) {
        receivedMessages.append(.requestCharacters)
    }

    func didSelecteRow(indexPath: IndexPath) {
        receivedMessages.append(.didSelecteRow)
    }
}

extension CharactersViewModelSpy {
    enum Message {
        case viewDidLoad
        case requestCharacters
        case didSelecteRow
    }
}
