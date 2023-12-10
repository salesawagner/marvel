//
//  DataContainer.swift
//  API
//
//  Created by Wagner Sales on 05/12/23.
//

import Foundation

struct DataContainer<Results: Decodable>: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: Results
}
