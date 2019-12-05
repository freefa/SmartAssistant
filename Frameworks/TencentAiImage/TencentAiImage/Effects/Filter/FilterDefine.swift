//
//  FilterDefine.swift
//  TencentAiImage
//
//  Created by Louis.B on 2019/12/5.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

/// 人脸滤镜编号
public enum FaceFilter: Int {
    /// 黛紫
    case dimPurple = 1
    /// 岩井
    case iwai
    /// 粉嫩
    case pink
    /// 错觉
    case illusion
    /// 暖阳
    case sunlight
    /// 浪漫
    case romantic
    /// 蔷薇
    case rose
    /// 睡莲
    case lotus
    /// 糖果玫瑰
    case candyRose
    /// 新叶
    case wakaba
    /// 尤加利
    case eucalyptus
    /// 墨
    case ink
    /// 玫瑰初雪
    case roseSnow
    /// 樱桃布丁
    case cherryPudding
    /// 白茶
    case whiteTea
    /// 甜薄荷
    case sweetMint
    /// 樱红
    case cherryRed
    /// 圣代
    case sundae
    /// 莫斯科
    case moscow
    /// 冲绳
    case okinawa
    /// 粉碧
    case pinkEmerald
    /// 地中海
    case mediterranean
    /// 首尔
    case seoul
    /// 佛罗伦萨
    case florence
    /// 札幌
    case sapporo
    /// 栀子
    case gardenia
    /// 东京
    case tokyo
    /// 昭和
    case showa
    /// 自然
    case natural
    /// 清逸
    case elegant
    /// 染
    case color
    /// 甜美
    case sweet
}


public let SceneryFilter = 1 ... 65

let kIMAGE_EFFECT_FILTER = "filter"

/// 滤镜:天天P图,适用于人脸
let kPATH_FACE_FILTER = "ptu/ptu_imgfilter"

/// 滤镜:腾讯AI LAB,适用于风景
let kPATH_SCENERY_FILTER = "vision/vision_imgfilter"

let kSCENERY_SESSION_ID = "session_id"

