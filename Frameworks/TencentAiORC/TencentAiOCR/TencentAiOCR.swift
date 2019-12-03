//
//  TencentAiOCR.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/12/3.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation
@_exported import UIKit
@_exported import TencentAiBase

open class TencentAiOCR: TBaseManager {
    public func IDCardOCR(image: UIImage, type: IDCardType, callback: @escaping (TResult, IDCard?) -> ()) {
        let api = IDCardOCRApi()
        api.image = image
        api.type = type
        TSessionManager.default.request(api: api) { (data, rspError) in
            guard rspError == nil else {
                TLog.d("IDCardOCR failed: \(rspError!.description)")
                callback((false, rspError), nil)
                return
            }
            
            let dict = try? JSONSerialization .jsonObject(with: data!, options: .allowFragments)
            if let info = dict as? Dictionary<String, Any> {
                if let code = info[kRESP_CODE] as? Int, code == TErrorCode.success.rawValue {
                    let resultInfo = info[kRESP_DATA] as! Dictionary<String, Any>
                    let resultData = try! JSONSerialization.data(withJSONObject: resultInfo, options: .fragmentsAllowed)
                    do {
                        let model = try JSONDecoder().decode(IDCard.self, from: resultData)
                        callback((true, rspError), model)
                    } catch {
                        TLog.d("decode json to model error: \(error.localizedDescription)")
                        callback((false, rspError), nil)
                    }
                } else {
                    callback((false, rspError), nil)
                }
            }
        }
    }
}