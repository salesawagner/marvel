// FONT: https://stackoverflow.com/questions/32163848/how-can-i-convert-a-string-to-an-md5-hash-in-ios-using-swift

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
