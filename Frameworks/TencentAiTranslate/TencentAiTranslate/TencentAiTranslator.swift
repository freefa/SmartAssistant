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
                          callback: @escaping (Bool, TextTranslateResult?) -> ()) {
        guard let array = TEXT_TRANSLATE_SUPPORTED[source], array.contains(target) else {
            TLog.d("unsupported translation: \(source.rawValue) to \(target.rawValue)")
            callback(false, nil)
            return
        }
        
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
                let code = info[kRESP_CODE] as! Int
                if code == TErrorCode.success.rawValue {
                    let resultInfo = info[kRESP_DATA] as! Dictionary<String, Any>
                    let resultData = try! JSONSerialization.data(withJSONObject: resultInfo, options: .fragmentsAllowed)
                    do {
                        let model = try JSONDecoder().decode(TextTranslateResult.self, from: resultData)
                        callback(true, model)
                    } catch {
                        TLog.d("decode json to model error")
                        callback(false, nil)
                    }
                } else {
                    callback(false, nil)
                }
            }
        }
    }
    
    public func translate(image: UIImage,
                          source: TLanguage,
                          target: TLanguage,
                          callback: @escaping (Bool, ImageTranslateResult?) -> ()) {
        let api = ImageTranslateApi()
        api.image = image
        api.source = source
        api.target = target
        TSessionManager.default.request(api: api) { (data, error) in
            guard error == nil else {
                TLog.d("imageTranslateError: \(error!.description)")
                callback(false, nil)
                return
            }
            
            let dict = try? JSONSerialization .jsonObject(with: data!, options: .allowFragments)
            if let info = dict as? Dictionary<String, Any> {
                let code = info[kRESP_CODE] as! Int
                if code == TErrorCode.success.rawValue {
                    let resultInfo = info[kRESP_DATA] as! Dictionary<String, Any>
                    let resultData = try! JSONSerialization.data(withJSONObject: resultInfo, options: .fragmentsAllowed)
                    do {
                        let model = try JSONDecoder().decode(ImageTranslateResult.self, from: resultData)
                        callback(true, model)
                    } catch {
                        TLog.d("decode json to model error")
                        callback(false, nil)
                    }
                } else {
                    callback(false, nil)
                }
            }
        }
    }
}

