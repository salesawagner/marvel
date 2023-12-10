//
//  BundleExtensions.swift
//  API
//
//  Created by Wagner Sales on 05/12/23.
//

import Foundation

extension Bundle {
    func getUrlFile(named fileName: String) -> URL? {
        guard let path = path(forResource: fileName, ofType: "json") else {
            return nil
        }

        return URL(fileURLWithPath: path)
    }
}
