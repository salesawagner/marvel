//
//  CharactersViewModelViewControllerSpy.swift
//  MarvelTests
//
//  Created by Wagner Sales on 10/12/23.
//

import XCTest
@testable import Marvel

final class CharactersViewViewControllerSpy: CharactersOutputProtocol {
    var receivedMessages: [Message] = []
    let expectation: XCTestExpectation?

    init(expectation: XCTestExpectation? = nil) {
        self.expectation = expectation
    }

    func startLoading() {
        receivedMessages.append(.startLoading)
    }

    func success() {
        receivedMessages.append(.success)
        expectation?.fulfill()
    }

    func failure() {
        receivedMessages.append(.failure)
        expectation?.fulfill()
    }
}

extension CharactersViewViewControllerSpy {
    enum Message {
        case startLoading
        case success
        case failure
    }
}
