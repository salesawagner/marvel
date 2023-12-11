//
//  CharactersViewModelSpy.swift
//  MarvelTests
//
//  Created by Wagner Sales on 10/12/23.
//

import XCTest
@testable import Marvel

final class CharactersViewModelSpy: CharactersInputProtocol {
    var receivedMessages: [Message] = []
    let expectation: XCTestExpectation?

    var viewController: CharactersOutputProtocol?
    var sections: [CharacterSectionViewModel] = []
    var collapsed: Set<Int> = .init()

    init(expectation: XCTestExpectation? = nil) {
        self.expectation = expectation
    }

    func viewDidLoad() {
        receivedMessages.append(.viewDidLoad)
    }

    func requestCharacters(nameStartsWith: String?) {
        receivedMessages.append(.requestCharacters)
    }

    func didSelectSection(section: Int) {
        receivedMessages.append(.didSelectSection)
        expectation?.fulfill()
    }

    func didSelectRow(indexPath: IndexPath) {
        receivedMessages.append(.didSelecteRow)
    }
}

extension CharactersViewModelSpy {
    enum Message {
        case viewDidLoad
        case requestCharacters
        case didSelectSection
        case didSelecteRow
    }
}
