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
    /// 生成一个指定字节长度的随机字符串
    /// - Parameter bytes: 目标字符串字节长度
    static func random(bytes: Int = 32) -> Self {
        let length = bytes / 2
        var buffer = Array<UInt8>(repeating: 0, count: length)
        var result = ""
        if SecRandomCopyBytes(kSecRandomDefault, length, &buffer) == 0 {
            for i in 0 ..< length {
                result += String(format: "%02X", buffer[i])
            }
        }
        return result
    }
    
    /// 获取字符串md5摘要,小写结果
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize(count: digestLen)
        return String(format: hash as String)
    }
    
    /// 获取字符串md5摘要,大写结果
    func MD5() -> String {
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
