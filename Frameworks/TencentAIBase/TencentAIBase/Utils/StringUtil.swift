//
//  StringUtil.swift
//  TencentAiBase
//
//  Created by Louis.B on 2019/11/28.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation
import CommonCrypto

public extension String {
    static func random(bytes: Int = 16) -> Self {
        var buffer = Array<UInt8>(repeating: 0, count: bytes)
        var result = ""
        if SecRandomCopyBytes(kSecRandomDefault, bytes, &buffer) == 0 {
            for i in 0..<bytes {
                result += String(format: "%02X", buffer[i])
            }
        }
        TLog.d("random String:\(result)")
        return result
    }
    
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02X", result[i])
        }
        result.deinitialize(count: digestLen)
        return String(format: hash as String)
    }
}
