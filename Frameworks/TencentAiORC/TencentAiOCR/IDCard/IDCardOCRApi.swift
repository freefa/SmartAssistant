//
//  IDCardORCApi.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/11/29.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

let TPATH_IDCARD_ORC = "ocr/ocr_idcardocr"

public enum IDCardType: Int {
    /// 正面
    case front
    /// 反面
    case back
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
        return [kIMG_PARAM : image!.toBase64(),
                kIMG_ID_CARD_TYPE : type!.rawValue]
    }
}
