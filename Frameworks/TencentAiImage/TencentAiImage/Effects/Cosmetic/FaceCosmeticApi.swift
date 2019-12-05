//
//  FaceCosmeticApi.swift
//  TencentAiImage
//
//  Created by Louis.B on 2019/12/5.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

class FaceCosmeticApi: ImageEffectApi {
    
    var cosmetic: CosmeticType?
    
    override func urlPath() -> String {
        return kPATH_FACE_COSMETIC
    }
    
    override func businessParams() -> Dictionary<String, Paramable> {
        var param = super.businessParams()
        param[kIMAGE_EFFECT_COSMETIC] = cosmetic!.rawValue
        return param
    }
}
