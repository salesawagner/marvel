//
//  APILogger.swift
//  API
//
//  Created by Wagner Sales on 06/12/23.
//

import Foundation

struct APILogger {
    // MARK: Public Methods

    /// Log into observability service
    ///
    /// - Attention:
    /// Do not log sensitive data, for debug use: `XPFLogger.mark()`.
    ///
    /// - Parameter message: debug message
    static func log(_ dto: APILoggerDTO, line: Int = #line, fileName: String = #file, funcName: String = #function) {
        mark(dto.message, attributes: dto.attributes, line: line, fileName: fileName, funcName: funcName)
    }

    /// Log into console
    ///
    /// - Parameter message: debug message
    static func mark(
        _ message: Any,
        attributes: [String: String]? = nil,
        line: Int = #line,
        fileName: String = #file,
        funcName: String = #function
    ) {
        #if DEBUG
        let info = format("\(message)", attributes: attributes, line: line, fileName: fileName, funcName: funcName)
            print("==> MARK - API \(info)")
        #endif
    }
}

// MARK: - Helpers

extension APILogger {
    // MARK: Private Methods

    private static func format(_ message: String,
                               attributes: [String: String]? = nil,
                               line: Int = #line,
                               fileName: String = #file,
                               funcName: String = #function) -> String {
        let fname = (fileName as NSString).lastPathComponent
        var formatted = """
        \n
        ==> [file: \(fname) function: \(funcName) line: \(line)]
        ==> \(message)
        \n
        """
        if let attributes = attributes {
            formatted += "==> \(attributes)"
        }

        formatted += "==><== \n"

        return formatted

    }

    // MARK: Internal Methods

    static func clean(_ msg: Any) {
        print(msg)
    }

    static func ln() {
        clean("")
    }
}
