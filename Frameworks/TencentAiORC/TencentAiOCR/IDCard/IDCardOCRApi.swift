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
//        let compressedImg = img.compressMemoryTo(size: 1)
        let data = img.jpegData(compressionQuality: 1)!
        TLog.d("idcard bytes: \(data.count), \(data.count / 1024)KB, \(data.count / 1024 / 1024)MB")
//        let string = data.base64EncodedString(options: .lineLength64Characters)
        let string = data.base64EncodedString()
        TLog.d("imgBase64length: \(string.count) charachters")
        TLog.d(string)
        return string
    }
}
