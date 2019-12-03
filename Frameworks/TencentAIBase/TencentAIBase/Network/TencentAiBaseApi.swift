//
//  TencentAiBaseApi.swift
//  TencentAiBase
//
//  Created by Louis.B on 2019/11/29.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

let TURL_BASE = "https://api.ai.qq.com/fcgi-bin/"

public protocol TApiProtocol {
    func baseUrl() -> String
    
    func urlPath() -> String
    
    func commonParams() -> Dictionary<String, Paramable>
    
    func businessParams() -> Dictionary<String, Paramable>
}

extension TApiProtocol {
    public func commonParams() -> Dictionary<String, Paramable> {
        return [kAPP_ID : TencentAiConfig.default.appId,
                kTIMESTAMP : Int(Date().timeIntervalSince1970),
                kNONCE_STRING : String.random()]
    }
}

open class TencentAiBaseApi: TApiProtocol {
    
    var callback: TDataCallback?
    
    public init() {}
    
    // MARK: TApiProtocol
    public func baseUrl() -> String {
        return TURL_BASE
    }
    
    public func urlPath() -> String {
        return ""
    }
    
    open func businessParams() -> Dictionary<String, Paramable> {
        return [String : Paramable]()
    }
}
