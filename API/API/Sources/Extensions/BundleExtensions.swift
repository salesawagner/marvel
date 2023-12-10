//
//  BundleExtensions.swift
//  API
//
//  Created by Wagner Sales on 05/12/23.
//

import Foundation

extension Bundle {
    func getUrlFile(named fileName: String) -> URL? {
        if let path = path(forResource: fileName, ofType: "json") { // From API SDK
            return URL(fileURLWithPath: path)
        } else if let bundleURL = url(forResource: "API", withExtension: "bundle"), // From app
            let bundle = Bundle(url: bundleURL),
            let path = bundle.path(forResource: fileName, ofType: "json") {
            return URL(fileURLWithPath: path)
        }

        return nil
    }
}
