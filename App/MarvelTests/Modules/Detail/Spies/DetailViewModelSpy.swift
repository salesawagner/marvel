//
//  DetailViewModelSpy.swift
//  MarvelTests
//
//  Created by Wagner Sales on 10/12/23.
//

import Foundation
@testable import Marvel

final class DetailViewModelSpy: DetailInputProtocol {
    var receivedMessages: [Message] = []
    var viewController: DetailOutputProtocol?
    var sections: [DetailSectionViewModel] = []

    func viewDidLoad() {
        receivedMessages.append(.viewDidLoad)
    }

    func requestComic() {
        receivedMessages.append(.requestComic)
    }
}

extension DetailViewModelSpy {
    enum Message {
        case viewDidLoad
        case requestComic
    }
}
