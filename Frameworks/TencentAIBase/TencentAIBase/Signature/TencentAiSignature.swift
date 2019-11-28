//
//  TencentAiSignature.swift
//  TencentAIBase
//
//  Created by Louis.B on 2019/11/28.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

public enum TencentAiSignature {
    public static func signatureWith(params: Dictionary<String, Paramable>) -> String? {
        TLog.d("signature:\(params), appId:\(TencentAiConfig.default.appId), appKey:\(TencentAiConfig.default.appKey)")
        var paramString = ""
        let keys = params.keys.sorted() { $0 < $1 }
        for key in keys {
            paramString += "\(key)=\(params[key]!.stringValue())&"
        }
        paramString += "app_key=\(TencentAiConfig.default.appKey)"
        TLog.d("param string: \(paramString)")
        let signature = paramString.md5()
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

