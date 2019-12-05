//
//  ImageEffectResult.swift
//  TencentAiImage
//
//  Created by Louis.B on 2019/12/5.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

open class ImageEffectResult: TencentAiBaseModel {
    public var image: UIImage?
    
    private enum CodingKeys: String, CodingKey {
        case image
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let base64Encoded = try container.decode(String.self, forKey: .image)
        let data = Data(base64Encoded: base64Encoded, options: .ignoreUnknownCharacters)
        if let imgData = data {
            image = UIImage.init(data: imgData)
        } else {
            TLog.d("decode image from base64 failed")
        }
        try super.init(from: decoder)
    }
}
