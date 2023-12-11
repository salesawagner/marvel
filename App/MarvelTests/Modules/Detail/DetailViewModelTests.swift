//
//  DetailViewModelTests.swift
//  MarvelTests
//
//  Created by Wagner Sales on 10/12/23.
//

import XCTest
import API
@testable import Marvel

final class DetailViewModelTests: XCTestCase {
    private func makeSUT(api: APIClient, expectation: XCTestExpectation? = nil) -> (
        DetailViewModel,
        DetailViewViewControllerSpy
    ) {
        let viewControllerSpy = DetailViewViewControllerSpy(expectation: expectation)
        let sut = DetailViewModel(api: api, name: "Tests", resourceURI: "")
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
            XCTAssertEqual(viewControllerSpy.receivedMessages, [.setTitle, .startLoading, .success])
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_requestComic_startLoading_shouldReceiveCorrectMessages() {
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local))
        sut.requestComic()

        XCTAssertEqual(viewControllerSpy.receivedMessages, [.startLoading])
    }

    func test_requestComic_success_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestDetail_success")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local), expectation: expectation)
        sut.requestComic()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.success))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_requestComic_failure_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestDetail_success")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPIMock(), expectation: expectation)
        sut.requestComic()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.failure))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }
}
