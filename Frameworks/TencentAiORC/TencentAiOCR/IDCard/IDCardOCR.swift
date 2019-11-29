//
//  IDCardOCR.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/11/29.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation
@_exported import TencentAiBase
@_exported import UIKit

open class IDCardOCR: TBaseManager {
    
    public func idCardOcr(image: UIImage,
                          type: IDCardType,
                          callback: @escaping (Bool, IDCardOCR, TResult) -> ()) {
        let api = IDCardOCRApi()
        api.image = image
        api.type = type
        TSessionManager.default.request(api: api) { (result, data) in
            TLog.d("idcard ocr result: \(result)")
            if let idData = data {
                let dict = try? JSONSerialization.jsonObject(with: idData, options: .allowFragments)
                TLog.d((dict as? Dictionary<String, Paramable>)?.description ?? "empty id info")
            }
        }
    }
}
