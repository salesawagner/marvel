//
//  TextObjectsExtensions.swift
//  Marvel
//
//  Created by Wagner Sales on 08/12/23.
//

import Foundation

extension Array where Element == TextObjects {
    var rowsViewModel: [DetailRowViewModel] {
        map { .init(text: $0.text) }
    }
}
