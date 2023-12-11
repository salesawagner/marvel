//
//  DetailViewControllerTests.swift
//  MarvelTests
//
//  Created by Wagner Sales on 06/12/23.
//

import XCTest
@testable import Marvel

final class DetailViewControllerTests: XCTestCase {
    private func makeSUT() -> (sut: DetailViewController, viewModel: DetailViewModelSpy) {
        let viewModelSpy = DetailViewModelSpy()
        let sut = DetailViewController.create(with: viewModelSpy)
        return (sut, viewModelSpy)
    }

    private func loadView(sut: DetailViewController) {
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
    
    func test_requestComic_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        loadView(sut: sut)
        sut.didRefresh(UIRefreshControl())

        XCTAssertTrue(viewModelSpy.receivedMessages.contains(.requestComic))
    }

    func test_setTitle_shouldReceiveCorrectMessages() {
        let (sut, _) = makeSUT()
        loadView(sut: sut)
        sut.setTitle("tests")

        XCTAssertEqual(sut.navigationItem.title, "tests")
    }

    func test_success_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        viewModelSpy.sections = .mock
        loadView(sut: sut)

        XCTAssertEqual(sut.tableView.numberOfSections, 1)
    }
}
