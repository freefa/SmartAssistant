//
//  DriverLisenceOCRApi.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/12/3.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

open class DriverLisenceOCRApi: GeneralOCRApi {
    var type: DriverLisenceType?
    
    open override func urlPath() -> String {
        return kPATH_DRIVER_LISENCE_OCR
    }
    
    open override func businessParams() -> Dictionary<String, Paramable> {
        var param = super.businessParams()
        param[kCOMMON_TYPE] = type!.rawValue
        return param
    }
}
