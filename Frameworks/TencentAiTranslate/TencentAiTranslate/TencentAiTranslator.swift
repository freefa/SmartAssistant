//
//  TencentAiTranslator.swift
//  TencentAiTranslate
//
//  Created by Louis.B on 2019/12/2.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation
@_exported import UIKit
@_exported import TencentAiBase

open class TencentAiTranslator: TBaseManager {
    public func translate(text: String,
                          source: TLanguage,
                          target: TLanguage,
                          callback: @escaping (TResult, TextTranslateResult?) -> ()) {
        guard let array = TEXT_TRANSLATE_SUPPORTED[source], array.contains(target) else {
            TLog.d("unsupported translation: \(source.rawValue) to \(target.rawValue)")
            let err = TError(code: -100001, description: "unsupported translation")
            let result = (success: false, error: err)
            callback(result, nil)
            return
        }
        
        let api = TextTranslateApi()
        api.text = text
        api.source = source
        api.target = target
        TSessionManager.default.request(api: api) { (data, rspError) in
            guard rspError == nil else {
                TLog.d("TextTranslator failed: \(rspError!.description)")
                callback((false, rspError), nil)
                return
            }
            let parseResult = TextTranslateResult.decodeFrom(data: data!)
            callback((parseResult.success, rspError), parseResult.model)
        }
    }
    
    public func translate(image: UIImage,
                          source: TLanguage,
                          target: TLanguage,
                          callback: @escaping (TResult, ImageTranslateResult?) -> ()) {
        let api = ImageTranslateApi()
        api.image = image
        api.source = source
        api.target = target
        TSessionManager.default.request(api: api) { (data, rspError) in
            guard rspError == nil else {
                TLog.d("imageTranslateError: \(rspError!.description)")
                callback((false, rspError), nil)
                return
            }
            let parseResult = ImageTranslateResult.decodeFrom(data: data!)
            callback((parseResult.success, rspError), parseResult.model)
        }
    }
}

