//
//  BankCardOCRApi.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/12/4.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

open class BankCardOCRApi: GeneralOCRApi {
    
    open override func urlPath() -> String {
        return kPATH_BANK_CARD_OCR
    }
}
