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

public enum IDCardType: Int {
    /// 正面
    case front
    /// 反面
    case back
}

open class IDCardOCRApi: TApi {
    /// 身份证图片data
    public var image: UIImage?
    /// 正反面
    public var type: IDCardType?
    
    /// TApiProtocol
    public override func urlPath() -> String {
        return TPATH_IDCARD_ORC
    }
    
    public override func businessParams() -> Dictionary<String, Paramable> {
        var param = [String : Paramable]()
        
        guard let string = imageString() else {
            TLog.d("invalid image string")
            return param
        }
        param[kOCR_BODY_IMAGE] = string
        param[kOCR_BODY_TYPE] = self.type?.rawValue
        return param
    }
    
    private func imageString() -> String? {
        guard let img = image else {
            TLog.d("image is null")
            return nil
        }
        let compressedImg = img.compressMemoryTo(size: 1)
        let data = compressedImg.jpegData(compressionQuality: 1)!
        return data.base64EncodedString()
    }
}
