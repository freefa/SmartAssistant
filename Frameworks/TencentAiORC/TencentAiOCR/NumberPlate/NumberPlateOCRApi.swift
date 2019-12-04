//
//  NumberPlateOCRApi.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/12/4.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

open class NumberPlateOCRApi: TencentAiApi {
    var image: UIImage?
    
    open override func businessParams() -> Dictionary<String, Paramable> {
        let compressed = image!.compressForBase64Encoding()
        return [kIMG_PARAM : compressed.toBase64()]
    }
    
    open override func urlPath() -> String {
        return kPATH_NUMBER_PLATE_OCR
    }
}
