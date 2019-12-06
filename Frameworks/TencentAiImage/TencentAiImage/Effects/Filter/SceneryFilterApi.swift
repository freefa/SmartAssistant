//
//  SceneryFilter.swift
//  TencentAiImage
//
//  Created by Louis.B on 2019/12/5.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

class SceneryFilterApi: ImageEffectApi {
    /// 滤镜编码 SCENERY_FILTER_CODE = 1 ... 65
    var filter: Int = 1
    
    public init(image: UIImage, filter: Int) {
        self.filter = filter
        super.init(image: image)
    }
    
    override func urlPath() -> String {
        return kPATH_SCENERY_FILTER
    }
    
    override func businessParams() -> Dictionary<String, Paramable> {
        var param = super.businessParams()
        param[kIMAGE_EFFECT_FILTER] = filter
        param[kSCENERY_SESSION_ID] = String.random()
        return param
    }
}
