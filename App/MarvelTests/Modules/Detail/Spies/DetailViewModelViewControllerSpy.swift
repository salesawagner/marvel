//
//  DetailViewModelViewControllerSpy.swift
//  MarvelTests
//
//  Created by Wagner Sales on 10/12/23.
//

import XCTest
@testable import Marvel

final class DetailViewViewControllerSpy: DetailOutputProtocol {
    var receivedMessages: [Message] = []
    let expectation: XCTestExpectation?

    init(expectation: XCTestExpectation? = nil) {
        self.expectation = expectation
    }

    func setTitle(_ title: String) {
        receivedMessages.append(.setTitle)
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

extension DetailViewViewControllerSpy {
    enum Message {
        case setTitle
        case startLoading
        case success
        case failure
    }
}
