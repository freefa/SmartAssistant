//
//  TencentAiImageEffect.swift
//  TencentAiImage
//
//  Created by Louis.B on 2019/12/5.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation
@_exported import TencentAiBase
@_exported import UIKit

open class TencentAiImageEffect: TBaseManager {
    public func faceFilter(image: UIImage, filter: FaceFilter, callback: @escaping (TResult, FaceFilterResult?) -> ()) {
        let api = FaceFilterApi()
        api.image = image
        api.filter = filter
        TSessionManager.default.request(api: api) { (data, rspError) in
            guard rspError == nil else {
                TLog.d("faceFilter failed: \(rspError!.description)")
                callback((false, rspError), nil)
                return
            }
            let parseResult = FaceFilterResult.decodeFrom(data: data!)
            callback((parseResult.success, rspError), parseResult.model)
        }
    }
    
    public func sceneryFilter(image: UIImage, filter: Int, callback: @escaping (TResult, SceneryFilterResult?) -> ()) {
        let api = SceneryFilterApi()
        api.image = image
        api.filter = filter
        TSessionManager.default.request(api: api) { (data, rspError) in
            guard rspError == nil else {
                TLog.d("faceFilter failed: \(rspError!.description)")
                callback((false, rspError), nil)
                return
            }
            let parseResult = SceneryFilterResult.decodeFrom(data: data!)
            callback((parseResult.success, rspError), parseResult.model)
        }
    }
}
