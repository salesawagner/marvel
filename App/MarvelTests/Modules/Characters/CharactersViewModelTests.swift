//
//  CharactersViewModelTests.swift
//  MarvelTests
//
//  Created by Wagner Sales on 10/12/23.
//

import XCTest
import API
@testable import Marvel

final class CharactersViewModelTests: XCTestCase {
    private func makeSUT(api: APIClient, expectation: XCTestExpectation? = nil) -> (
        CharactersViewModel,
        CharactersViewViewControllerSpy
    ) {
        let viewControllerSpy = CharactersViewViewControllerSpy(expectation: expectation)
        let sut = CharactersViewModel(api: api)
        sut.viewController = viewControllerSpy

        return (sut, viewControllerSpy)
    }

    func test_viewDidLoad_success_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "viewDidLoad_success")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local), expectation: expectation)
        sut.viewDidLoad()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertEqual(viewControllerSpy.receivedMessages, [.startLoading, .success])
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_viewSelectSection_shouldReceiveCorrectMessages() {
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local))
        sut.didSelectSection(section: 0)
        XCTAssertEqual(viewControllerSpy.receivedMessages, [.updateSection])
    }

    func test_requestCharacters_startLoading_shouldReceiveCorrectMessages() {
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local))
        sut.requestCharacters()

        XCTAssertEqual(viewControllerSpy.receivedMessages, [.startLoading])
    }

    func test_requestCharacters_success_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestCharacters_success")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local), expectation: expectation)
        sut.requestCharacters()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.success))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_requestCharacters_failure_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestCharacters_failure")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPIMock(), expectation: expectation)
        sut.requestCharacters()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.failure))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }
}
