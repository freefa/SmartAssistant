//
//  HandWritingOCRApi.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/12/4.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

open class HandWritingOCRApi: GeneralOCRApi {
    var imageUrl: String?
    
    open override func urlPath() -> String {
        return kPATH_HAND_WRITING_OCR
    }
    
    open override func businessParams() -> Dictionary<String, Paramable> {
        if let url = imageUrl {
            return [kIMG_URL : url]
        }
        return super.businessParams()
    }
}
