//
//  TencentAiSignature.swift
//  TencentAIBase
//
//  Created by Louis.B on 2019/11/28.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

private let URL_ENCODE_ALLOWED_CHARS = CharacterSet.init(charactersIn: "-._0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")

public enum TencentAiSignature {
    public static func signatureWith(params: Dictionary<String, Paramable>) -> String? {
        guard TencentAiConfig.default.appId > 0, !TencentAiConfig.default.appKey.isEmpty else {
            TLog.d("app does not register to Tencent AI")
            return nil
        }
        TLog.d("signature:\(params), appId:\(TencentAiConfig.default.appId), appKey:\(TencentAiConfig.default.appKey)")
        var paramString = ""
        let keys = params.keys.sorted() { $0 < $1 }
        for key in keys {
            var value = params[key]!.stringValue()
            if !value.isEmpty {
                value = value.addingPercentEncoding(withAllowedCharacters: URL_ENCODE_ALLOWED_CHARS)!
                value = value.replacingOccurrences(of: " ", with: "+")
                TLog.d("added percent value: \(value)")
                paramString += "\(key)=\(value)&"
            }
        }
        paramString += "app_key=\(TencentAiConfig.default.appKey)"
        TLog.d("param string: \(paramString)")
        let signature = paramString.MD5()
        TLog.d("signature: \(signature)")
        return signature
    }
}

public protocol Paramable {
    func stringValue() -> String
}

extension String: Paramable {
    public func stringValue() -> String {
        return self
    }
}

extension Int: Paramable {
    public func stringValue() -> String {
        return String(self)
    }
}
extension Int8: Paramable {
    public func stringValue() -> String {
        return String(self)
    }
}
extension Int16: Paramable {
    public func stringValue() -> String {
        return String(self)
    }
}
extension Int32: Paramable {
    public func stringValue() -> String {
        return String(self)
    }
}
extension Int64: Paramable {
    public func stringValue() -> String {
        return String(self)
    }
}
extension UInt: Paramable {
    public func stringValue() -> String {
        return String(self)
    }
}
extension UInt8: Paramable {
    public func stringValue() -> String {
        return String(self)
    }
}
extension UInt16: Paramable {
    public func stringValue() -> String {
        return String(self)
    }
}
extension UInt32: Paramable {
    public func stringValue() -> String {
        return String(self)
    }
}
extension UInt64: Paramable {
    public func stringValue() -> String {
        return String(self)
    }
}
extension Float: Paramable {
    public func stringValue() -> String {
        return String(self)
    }
}
extension Double: Paramable {
    public func stringValue() -> String {
        return String(self)
    }
}

