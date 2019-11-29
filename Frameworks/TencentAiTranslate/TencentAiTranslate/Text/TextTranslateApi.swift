//
//  TextTranslateApi.swift
//  TencentAiTranslate
//
//  Created by Louis.B on 2019/11/29.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

let TPATH_TEXT_TRANSLATE = "nlp/nlp_texttranslate"

open class TextTranslateApi: TApi {
    /// 待翻译文本
    public var text: String?
    /// 源语言
    public var source: String?
    /// 目标语言
    public var target: String?
    
    open override func businessParams() -> Dictionary<String, Paramable> {
        return ["text" : "What's the weather like today",
                "source" : "en",
                "target" : "zh"]
    }
    
    open override func urlPath() -> String {
        return TPATH_TEXT_TRANSLATE
    }
}
