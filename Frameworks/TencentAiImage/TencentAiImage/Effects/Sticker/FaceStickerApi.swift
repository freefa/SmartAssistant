//
//  FaceStickerApi.swift
//  TencentAiImage
//
//  Created by Louis.B on 2019/12/6.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

class FaceStickerApi: ImageEffectApi {
    
    var sticker = StickerType.Envolope
    
    public init(image: UIImage, sticker: StickerType) {
        self.sticker = sticker
        super.init(image: image)
    }
    
    override func urlPath() -> String {
        return kPATH_FACE_STICKER
    }
    
    override func businessParams() -> Dictionary<String, Paramable> {
        var param = super.businessParams()
        param[kIMAGE_EFFECT_STICKER] = self.sticker.rawValue
        return param
    }
}
