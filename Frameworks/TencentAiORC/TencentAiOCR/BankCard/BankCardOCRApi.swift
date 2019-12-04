//
//  BankCardOCRApi.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/12/4.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

open class BankCardOCRApi: TencentAiApi {
    var image: UIImage?
    
    open override func urlPath() -> String {
        return kPATH_BANK_CARD_OCR
    }
    
    open override func businessParams() -> Dictionary<String, Paramable> {
        let compressedImage = image!.compressForBase64Encoding()
        return [kIMG_PARAM : compressedImage.toBase64()]
    }
}
