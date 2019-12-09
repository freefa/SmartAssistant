//
//  NumberPlateOCRApi.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/12/4.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

open class NumberPlateOCRApi: GeneralOCRApi {
    
    var imageUrl: String?
    
    open override func urlPath() -> String {
        return kPATH_NUMBER_PLATE_OCR
    }
    
    open override func businessParams() -> Dictionary<String, Paramable> {
        if let url = imageUrl {
            return [kTENCENT_AI_IMAGE_URL : url]
        }
        return super.businessParams()
    }
}
