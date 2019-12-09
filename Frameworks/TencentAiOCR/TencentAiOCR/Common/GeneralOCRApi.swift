//
//  CommonOCRApi.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/12/4.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

open class GeneralOCRApi: TencentAiApi {
    var image: UIImage?
    
    open override func urlPath() -> String {
        return KPATH_GENERAL_OCR
    }
    
    open override func businessParams() -> Dictionary<String, Paramable> {
        let compressed = image!.compressForBase64Encoding()
        return [kTENCENT_AI_IMAGE : compressed.toBase64()]
    }
}
