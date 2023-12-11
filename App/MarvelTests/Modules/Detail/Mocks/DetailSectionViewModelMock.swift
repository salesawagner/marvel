//
//  DetailectionViewModelMock.swift
//  MarvelTests
//
//  Created by Wagner Sales on 10/12/23.
//

import Foundation
@testable import Marvel

extension DetailSectionViewModel {
    static var mock: DetailSectionViewModel {
        .init(thumbnailURL: URL(string: ""), rows: [])
    }
}

extension Array where Element == DetailSectionViewModel {
    static var mock: [DetailSectionViewModel] {
        [.mock]
    }
}
