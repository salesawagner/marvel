//
//  CharactersViewControllerTests.swift
//  MarvelTests
//
//  Created by Wagner Sales on 06/12/23.
//

import XCTest
@testable import Marvel

final class CharactersViewControllerTests: XCTestCase {
    private func makeSUT() -> (sut: CharactersViewController, viewModel: CharactersViewModelSpy) {
        let viewModelSpy = CharactersViewModelSpy()
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

    func test_didSelectRow_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        viewModelSpy.sections = .mock
        loadView(sut: sut)

        sut.tableView(UITableView(), didSelectRowAt: .init(row: 0, section: 0))
        XCTAssertTrue(viewModelSpy.receivedMessages.contains(.didSelecteRow))
    }
}
