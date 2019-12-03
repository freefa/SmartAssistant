//
//  IDCardORCApi.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/11/29.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

let TPATH_IDCARD_ORC = "ocr/ocr_idcardocr"

public let kOCR_BODY_IMAGE = "image"
public let kOCR_BODY_TYPE = "type"

public enum IDCardType: String {
    /// 正面
    case front = "0"
    /// 反面
    case back = "1"
}

open class IDCardOCRApi: TencentAiApi {
    /// 身份证图片data
    public var image: UIImage?
    /// 正反面
    public var type: IDCardType?
    
    /// TApiProtocol
    public override func urlPath() -> String {
        return TPATH_IDCARD_ORC
    }
    
    public override func businessParams() -> Dictionary<String, Paramable> {
        return ["image" : image!.toBase64(),
                "card_type" : type!.rawValue]
    }
}
