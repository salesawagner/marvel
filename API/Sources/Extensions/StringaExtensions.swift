//
//  StringaExtensions.swift
//  API
//
//  Created by Wagner Sales on 06/12/23.
//

import Foundation

extension String {
    public var md5: String {
        return encodeMD5(digest: md5Digest)
    }

    public var md5Digest: [Byte] {
        let bytes = [Byte](self.utf8)
        let digest = calculateMD5(bytes)
        return digest.digest
    }
}
