//
//  ImageTranslateResult.swift
//  TencentAiTranslate
//
//  Created by Louis.B on 2019/12/2.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

open class ImageTranslateResult: TencentAiBaseModel {
    public var results: [ImageTranslateItem]?
    
    private enum KeysMap: String, CodingKey {
        case results = "image_records"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: KeysMap.self)
        results = try [container.decode(ImageTranslateItem.self, forKey: .results)]
        try super.init(from: decoder)
    }
}

open class ImageTranslateItem: TencentAiBaseModel {
    public var source: String?
    
    public var target: String?
    
    public var x: Int?
    
    public var y: Int?
    
    public var width: Int?
    
    public var height: Int?
    
    private enum KeysMap: String, CodingKey {
        case source = "source_text"
        case target = "target_text"
    }
}
