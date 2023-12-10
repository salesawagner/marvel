//
//  MarvelResponse.swift
//  API
//
//  Created by Wagner Sales on 05/12/23.
//

import Foundation

struct MarvelResponse<Response: Decodable>: Decodable {
    let status: String?
    let message: String?
    let data: DataContainer<Response>?
}
