//
//  CharactersViewControllerTests.swift
//  MarvelTests
//
//  Created by Wagner Sales on 06/12/23.
//

import XCTest
@testable import Marvel

final class CharactersViewControllerTests: XCTestCase {
    private func makeSUT(expectation: XCTestExpectation? = nil) -> (
        sut: CharactersViewController,
        viewModel: CharactersViewModelSpy
    ) {
        let viewModelSpy = CharactersViewModelSpy(expectation: expectation)
        let sut = CharactersViewController.create(with: viewModelSpy)
        return (sut, viewModelSpy)
    }

    private func loadView(sut: CharactersViewController) {
        let window = UIWindow()
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests

    func test_viewDidLoad_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        loadView(sut: sut)

        XCTAssertEqual(viewModelSpy.receivedMessages, [.viewDidLoad])
    }

    func test_searchBarSearchButtonClicked_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        loadView(sut: sut)
        sut.searchBarSearchButtonClicked(UISearchBar())

        XCTAssertEqual(viewModelSpy.receivedMessages, [.viewDidLoad, .requestCharacters])
    }

    func test_didSelectSection_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "didSelectSection")
        let (sut, viewModelSpy) = makeSUT(expectation: expectation)
        viewModelSpy.sections = .mock
        loadView(sut: sut)

        let tapGesture = UITapGestureRecognizer()
        let view = UIView()
        view.tag = 0
        view.addGestureRecognizer(tapGesture)
        sut.didSelectSection(tapGesture)

        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        switch result {
        case .completed:
            XCTAssertTrue(viewModelSpy.receivedMessages.contains(.didSelectSection))
            print(viewModelSpy.receivedMessages)
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_didSelectRow_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        viewModelSpy.sections = .mock
        loadView(sut: sut)

        sut.tableView(UITableView(), didSelectRowAt: .init(row: 0, section: 0))
        XCTAssertTrue(viewModelSpy.receivedMessages.contains(.didSelecteRow))
    }
}
