//
//  TBaseRequest.swift
//  TencentAiBase
//
//  Created by Louis.B on 2019/11/29.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

public class TBaseRequest: NSMutableURLRequest {
    public var uuid: String
    
    public init(url: URL, uuid: String) {
        self.uuid = uuid
        super.init(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: TAPI_TIMEOUT)
    }
    
    required init?(coder: NSCoder) {
        self.uuid = UUID().uuidString
        super.init(coder: coder)
    }
}
