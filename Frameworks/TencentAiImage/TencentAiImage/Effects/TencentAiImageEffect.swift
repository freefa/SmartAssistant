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
    /// 为人脸图片添加滤镜效果
    /// - Parameters:
    ///   - image: 待处理人脸原图
    ///   - filter: 滤镜类型 @see enum FaceFilter
    ///   - callback: 回调
    public func faceFilter(image: UIImage, filter: FaceFilter, callback: @escaping (TResult, FaceFilterResult?) -> ()) {
        let api = FaceFilterApi(image: image, filter: filter)
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
    
    /// 为风景图片添加滤镜效果
    /// - Parameters:
    ///   - image: 待处理图片
    ///   - filter: 风景滤镜编号 @see SCENERY_FILTER_CODE
    ///   - callback: 回调
    public func sceneryFilter(image: UIImage, filter: Int, callback: @escaping (TResult, SceneryFilterResult?) -> ()) {
        let api = SceneryFilterApi(image: image, filter: filter)
        TSessionManager.default.request(api: api) { (data, rspError) in
            guard rspError == nil else {
                TLog.d("sceneryFilter failed: \(rspError!.description)")
                callback((false, rspError), nil)
                return
            }
            let parseResult = SceneryFilterResult.decodeFrom(data: data!)
            callback((parseResult.success, rspError), parseResult.model)
        }
    }
    
    /// 为人脸图片添加美妆效果
    /// - Parameters:
    ///   - image: 待处理图片
    ///   - cosmetic: 美妆类型 @see enum CosmeticType
    ///   - callback: 回调
    public func faceCosmetic(image: UIImage, cosmetic: CosmeticType, callback: @escaping (TResult, FaceCosmetic?) -> ()) {
        let api = FaceCosmeticApi(image: image, cosmetic: cosmetic)
        TSessionManager.default.request(api: api) { (data, rspError) in
            guard rspError == nil else {
                TLog.d("faceCosmetic failed: \(rspError!.description)")
                callback((false, rspError), nil)
                return
            }
            let parseResult = FaceCosmetic.decodeFrom(data: data!)
            callback((parseResult.success, rspError), parseResult.model)
        }
    }
    
    /// 为人脸图片添加变妆效果
    /// - Parameters:
    ///   - image: 待处理图片
    ///   - decoration: 变妆类型 @see enum DecorationType
    ///   - callback: 回调
    public func faceDecoration(image: UIImage, decoration: DecorationType, callback: @escaping (TResult, FaceDecoration?) -> ()) {
        let api = FaceDecorationApi(image: image, decoration: decoration)
        TSessionManager.default.request(api: api) { (data, rspError) in
            guard rspError == nil else {
                TLog.d("FaceDecoration failed: \(rspError!.description)")
                callback((false, rspError), nil)
                return
            }
            let parseResult = FaceDecoration.decodeFrom(data: data!)
            callback((parseResult.success, rspError), parseResult.model)
        }
    }
    
    /// 获取图片大头贴效果
    /// - Parameters:
    ///   - image: 待处理图片
    ///   - sticker: 大头贴类型 @see enum StickerType
    ///   - callback: 回调
    public func faceSticker(image: UIImage, sticker: StickerType, callback: @escaping (TResult, FaceSticker?) -> ()) {
        let api = FaceStickerApi(image: image, sticker: sticker)
        TSessionManager.default.request(api: api) { (data, rspError) in
            guard rspError == nil else {
                TLog.d("FaceSticker failed: \(rspError!.description)")
                callback((false, rspError), nil)
                return
            }
            let parseResult = FaceSticker.decodeFrom(data: data!)
            callback((parseResult.success, rspError), parseResult.model)
        }
    }
}
