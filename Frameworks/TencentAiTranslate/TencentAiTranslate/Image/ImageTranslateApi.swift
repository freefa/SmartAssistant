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
    public var image: UIImage?
    public var source: TLanguage?
    public var target: TLanguage?
    
    override func businessParams() -> Dictionary<String, Paramable> {
        return ["source" : source!.rawValue,
                "target" : target!.rawValue,
                "session_id" : String.random(),
                "image" : image!.toBase64(),
                "scene" : "doc"]
    }
    
    override func urlPath() -> String {
        return TPATH_IMAGE_TRANSLATE
    }
}
