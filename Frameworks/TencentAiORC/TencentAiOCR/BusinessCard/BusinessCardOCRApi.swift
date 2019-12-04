//
//  BusinessCardOCRApi.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/12/3.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

open class BusinessCardOCRApi: GeneralOCRApi {
    
    open override func urlPath() -> String {
        return TPATH_BUSINESS_CARD_OCR
    }
    
}
