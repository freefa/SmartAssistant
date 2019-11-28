//
//  TencentAiConfig.swift
//  TencentAIBase
//
//  Created by Louis.B on 2019/11/28.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

public struct TencentAiConfig {
    static var `default` = TencentAiConfig(appId: -1, appKey: "")
    
    var appId: Int
    
    var appKey: String
    
    public static func register(appId: Int, appKey: String) {
        `default`.appId = appId
        `default`.appKey = appKey
        TLog.d("register Tencent AI\nappId:\(appId)\nappKey:\(appKey)")
    }
}
