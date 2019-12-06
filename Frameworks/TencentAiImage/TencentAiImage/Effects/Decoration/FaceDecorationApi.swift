//
//  FaceDecorationApi.swift
//  TencentAiImage
//
//  Created by Louis.B on 2019/12/6.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

class FaceDecorationApi: ImageEffectApi {
    var decoration = DecorationType.CuteRabbit
    
    init(image: UIImage, decoration: DecorationType) {
        self.decoration = decoration
        super.init(image: image)
    }
    
    override func urlPath() -> String {
        return kPATH_FACE_DECORATION
    }
    
    override func businessParams() -> Dictionary<String, Paramable> {
        var param = super.businessParams()
        param[kIMAGE_EFFECT_DECORATION] = decoration.rawValue
        return param
    }
}
