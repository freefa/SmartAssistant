//
//  ImageEffectApi.swift
//  TencentAiImage
//
//  Created by Louis.B on 2019/12/5.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

class ImageEffectApi: TencentAiApi {
    var image: UIImage?
    
    override func businessParams() -> Dictionary<String, Paramable> {
        let compressed = image!.compressForBase64Encoding(memory: 0.5)
        return [kTENCENT_AI_IMAGE : compressed.toBase64()]
    }
}
