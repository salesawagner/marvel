//
//  StringaExtensions.swift
//  API
//
//  Created by Wagner Sales on 06/12/23.
//

import Foundation
import CommonCrypto

// FONT: https://stackoverflow.com/questions/32163848/how-can-i-convert-a-string-to-an-md5-hash-in-ios-using-swift
extension String {
    var md5: String {
        MD5(string: self).base64EncodedString()
    }

    func MD5(string: String) -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using: .utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_SHA256(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }

        return digestData
    }
}
