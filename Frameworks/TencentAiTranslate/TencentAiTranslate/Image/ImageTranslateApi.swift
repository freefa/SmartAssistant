//
//  ImageTranslateApi.swift
//  TencentAiTranslate
//
//  Created by Louis.B on 2019/12/2.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

let TPATH_IMAGE_TRANSLATE = "nlp/nlp_imagetranslate"

class ImageTranslateApi: TencentAiApi {
    public var image: UIImage?
    public var source: TLanguage?
    public var target: TLanguage?
    
    override func businessParams() -> Dictionary<String, Paramable> {
        let compressed = image!.compressForBase64Encoding()
        return ["source" : source!.rawValue,
                "target" : target!.rawValue,
                "session_id" : String.random(),
                "image" : compressed.toBase64(),
                "scene" : "doc"]
    }
    
    override func urlPath() -> String {
        return TPATH_IMAGE_TRANSLATE
    }
}
