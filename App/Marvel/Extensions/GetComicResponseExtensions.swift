//
//  GetComicResponseExtensions.swift
//  Marvel
//
//  Created by Wagner Sales on 08/12/23.
//

import Foundation

extension Array where Element == GetComicResponse {
    var sectionsViewModel: [DetailSectionViewModel] {
        map { .init(thumbnailURL: $0.images.first?.url, rows: $0.textObjects.rowsViewModel) }
    }
}
