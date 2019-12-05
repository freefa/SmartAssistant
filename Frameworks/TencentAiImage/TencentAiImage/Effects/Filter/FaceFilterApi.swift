//
//  FaceFilterApi.swift
//  TencentAiImage
//
//  Created by Louis.B on 2019/12/5.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

class FaceFilterApi: ImageEffectApi {
    var filter = FaceFilter.natural
    
    override func urlPath() -> String {
        return kPATH_FACE_FILTER
    }
    
    override func businessParams() -> Dictionary<String, Paramable> {
        var param = super.businessParams()
        param[kIMAGE_EFFECT_FILTER] = filter.rawValue
        return param
    }
}
