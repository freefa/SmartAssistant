//
//  BusinessCardOCRApi.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/12/3.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

let TPATH_BUSINESS_CARD_OCR = "ocr/ocr_bcocr"

open class BusinessCardOCRApi: TencentAiApi {
    
    var image: UIImage?
    
    open override func urlPath() -> String {
        return TPATH_BUSINESS_CARD_OCR
    }
    
    open override func businessParams() -> Dictionary<String, Paramable> {
        let compressed = image!.compressForBase64Encoding()
        return [kIMG_PARAM : compressed.toBase64()]
    }
}
