//
//  IDCardORCApi.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/11/29.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

open class IDCardOCRApi: GeneralOCRApi {
    /// 正反面
    public var type: IDCardType?
    
    /// TApiProtocol
    public override func urlPath() -> String {
        return TPATH_IDCARD_ORC
    }
    
    public override func businessParams() -> Dictionary<String, Paramable> {
        var param = super.businessParams()
        param[kIMG_ID_CARD_TYPE] = type!.rawValue
        return param
    }
}
