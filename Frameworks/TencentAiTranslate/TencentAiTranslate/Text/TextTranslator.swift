//
//  TextTranslator.swift
//  TencentAiTranslate
//
//  Created by Louis.B on 2019/11/29.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation
@_exported import TencentAiBase

open class TextTranslator: TBaseManager {
    
    public func translate(text: String, source: String = "zh", target: String = "en") {
        let api = TextTranslateApi()
        TSessionManager.default.request(api: api) { (result, data) in
            
        }
    }
}
