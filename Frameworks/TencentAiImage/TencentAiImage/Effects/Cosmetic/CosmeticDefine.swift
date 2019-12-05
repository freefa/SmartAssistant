//
//  CosmeticDefine.swift
//  TencentAiImage
//
//  Created by Louis.B on 2019/12/5.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

public enum CosmeticType: Int {
    /// 日系妆:芭比粉
    case JpBarbiePink = 1
    /// 日系妆:清透
    case JpClear
    /// 日系妆:烟灰
    case JpSoot
    /// 日系妆:自然
    case JpNature
    /// 日系妆:樱花粉
    case JpCherryPink
    /// 日系妆:原宿红
    case JpHarajukuRed
    /// 韩妆:闪亮
    case KrShiny
    /// 韩妆:粉紫
    case KrPinkPurple
    /// 韩妆:粉嫩
    case KrPink
    /// 韩妆:自然
    case KrNature
    /// 韩妆:清透
    case KrClear
    /// 韩妆:大地色
    case KrEarth
    /// 韩妆:玫瑰
    case KrRose
    /// 裸妆:自然
    case nature
    /// 裸妆:清透
    case clear
    /// 裸妆:桃粉
    case peachPink
    /// 裸妆:橘粉
    case orangePink
    /// 裸妆:春夏
    case springSummer
    /// 裸妆:秋冬
    case autumnWinter
    /// 主题妆:经典复古
    case classicRetro
    /// 主题妆:性感混血
    case SexyMixedRace
    /// 主题妆:炫彩明眸
    case BrightEyes
    /// 主题妆:紫色魅惑
    case purpleCharm
}

public let COSMETIC_TYPES = [[CosmeticType.JpBarbiePink : "日系妆:芭比粉"],
                             [CosmeticType.JpClear : "日系妆:清透"],
                             [CosmeticType.JpSoot : "日系妆:烟灰"],
                             [CosmeticType.JpNature : "日系妆:自然"],
                             [CosmeticType.JpCherryPink : "日系妆:樱花粉"],
                             [CosmeticType.JpHarajukuRed : "日系妆:原宿红"],
                             [CosmeticType.KrShiny : "韩妆:闪亮"],
                             [CosmeticType.KrPinkPurple : "韩妆:粉紫"],
                             [CosmeticType.KrPink : "韩妆:粉嫩"],
                             [CosmeticType.KrNature : "韩妆:自然"],
                             [CosmeticType.KrClear : "韩妆:清透"],
                             [CosmeticType.KrEarth : "韩妆:大地色"],
                             [CosmeticType.KrRose : "韩妆:玫瑰"],
                             [CosmeticType.nature : "裸妆:自然"],
                             [CosmeticType.clear : "裸妆:清透"],
                             [CosmeticType.peachPink : "裸妆:桃粉"],
                             [CosmeticType.orangePink : "裸妆:橘粉"],
                             [CosmeticType.springSummer : "裸妆:春夏"],
                             [CosmeticType.autumnWinter : "裸妆:秋冬"],
                             [CosmeticType.classicRetro : "主题妆:经典复古"],
                             [CosmeticType.SexyMixedRace : "主题妆:性感混血"],
                             [CosmeticType.BrightEyes : "主题妆:炫彩明眸"],
                             [CosmeticType.purpleCharm : "主题妆:紫色魅惑"]]

let kIMAGE_EFFECT_COSMETIC = "cosmetic"
