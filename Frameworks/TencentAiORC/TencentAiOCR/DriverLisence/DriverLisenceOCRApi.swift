//
//  DriverLisenceOCRApi.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/12/3.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

open class DriverLisenceOCRApi: TencentAiApi {
    var image: UIImage?
    var type: DriverLisenceType?
    
    open override func urlPath() -> String {
        return kPATH_DRIVER_LISENCE_OCR
    }
    
    open override func businessParams() -> Dictionary<String, Paramable> {
        let compressedImage = image!.compressForBase64Encoding()
        return [kIMG_PARAM : compressedImage.toBase64(),
                kCOMMON_TYPE : type!.rawValue]
    }
}
