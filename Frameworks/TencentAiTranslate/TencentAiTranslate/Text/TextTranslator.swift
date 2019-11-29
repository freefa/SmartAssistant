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
    
    public func translate(text: String,
                          source: String,
                          target: String,
                          callback: @escaping (Bool, TextTranslateResult?) -> ()) {
        let api = TextTranslateApi()
        api.text = text
        api.source = source
        api.target = target
        TSessionManager.default.request(api: api) { (data, error) in
            guard error == nil else {
                TLog.d("TextTranslator failed: \(error!.description)")
                callback(false, nil)
                return
            }
            let dict = try? JSONSerialization .jsonObject(with: data!, options: .allowFragments)
            if let info = dict as? Dictionary<String, Any> {
                let code = info["ret"] as! Int
                if code == TErrorCode.success.rawValue {
                    let resultInfo = info["data"] as! Dictionary<String, Any>
                    let model = TextTranslateResult()
                    model.source = (resultInfo["source_text"] as! String)
                    model.target = (resultInfo["target_text"] as! String)
                    callback(true, model)
                } else {
                    callback(false, nil)
                }
            }
        }
    }
}
