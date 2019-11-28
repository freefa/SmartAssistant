//
//  TencentAiSignature.swift
//  TencentAIBase
//
//  Created by Louis.B on 2019/11/28.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

public enum TencentAiSignature {
    public static func signatureWith(params: Dictionary<String, Encodable>) -> String? {
        TLog.d("signature:\(params), appId:\(TencentAiConfig.default.appId), appKey:\(TencentAiConfig.default.appKey)")
        return nil
    }
}
