//
//  ImageTranslateApi.swift
//  TencentAiTranslate
//
//  Created by Louis.B on 2019/12/2.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

let TPATH_IMAGE_TRANSLATE = "nlp/nlp_imagetranslate"

class ImageTranslateApi: TApi {
    public var image: String?
    public var source: String?
    public var target: String?
    
    override func businessParams() -> Dictionary<String, Paramable> {
        return ["source" : source!,
                "target" : target!,
                "session_id" : String.random(),
                "image" : image!,
                "scene" : "doc"]
    }
    
    override func urlPath() -> String {
        return TPATH_IMAGE_TRANSLATE
    }
}
