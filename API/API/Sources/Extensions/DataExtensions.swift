//
//  DataExtensions.swift
//  API
//
//  Created by Wagner Sales on 06/12/23.
//

import Foundation

extension Data {
    var string: String {
        String(decoding: self, as: UTF8.self)
    }
}
