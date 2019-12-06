//
//  FaceCosmeticApi.swift
//  TencentAiImage
//
//  Created by Louis.B on 2019/12/5.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

class FaceCosmeticApi: ImageEffectApi {
    
    var cosmetic = CosmeticType.JpBarbiePink
    
    public init(image: UIImage, cosmetic: CosmeticType) {
        self.cosmetic = cosmetic
        super.init(image: image)
    }
    
    override func urlPath() -> String {
        return kPATH_FACE_COSMETIC
    }
    
    override func businessParams() -> Dictionary<String, Paramable> {
        var param = super.businessParams()
        param[kIMAGE_EFFECT_COSMETIC] = cosmetic.rawValue
        return param
    }
}
