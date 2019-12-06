//
//  ImageEffectDefine.swift
//  TencentAiImage
//
//  Created by Louis.B on 2019/12/5.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

// MARK:人脸滤镜
/// 滤镜:天天P图,适用于人脸
let kPATH_FACE_FILTER = "ptu/ptu_imgfilter"

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

// MARK:风景滤镜
/// 滤镜:腾讯AI LAB,适用于风景
let kPATH_SCENERY_FILTER = "vision/vision_imgfilter"

/// 风景滤镜编号范围
public let SCENERY_FILTER_CODE = 1 ... 65

/// 人脸滤镜 & 风景滤镜 类型请求字段
let kIMAGE_EFFECT_FILTER = "filter"

/// 风景滤镜请求字段session_id
let kSCENERY_SESSION_ID = "session_id"

// MARK:人脸美妆
/// 人脸美妆
let kPATH_FACE_COSMETIC = "ptu/ptu_facecosmetic"

/// 美妆类型
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

/// 人脸美妆类型请求字段
let kIMAGE_EFFECT_COSMETIC = "cosmetic"

// MARK:人脸变妆
/// 人脸变妆
let kPATH_FACE_DECORATION = "ptu/ptu_facedecoration"

/// 变妆类型
public enum DecorationType: Int {
    /// 埃及妆
    case Egypt = 1
    /// 巴西土著妆
    case Brazilian
    /// 灰姑娘妆
    case Cinderella
    /// 恶魔妆
    case Demon
    /// 武媚娘妆
    case WuMeiNiang
    /// 星光薰衣草
    case StarlightLavender
    /// 花千骨
    case HuaQianGu
    /// 僵尸妆
    case Zombie
    /// 爱国装
    case Patriotic
    /// 小胡子妆
    case Moustache
    /// 美羊羊妆
    case BeautySheep
    /// 火影鸣人妆
    case Naruto
    /// 刀马旦妆
    case PekingOpera
    /// 泡泡妆
    case Bubble
    /// 桃花妆
    case PeachBlossom
    /// 女皇妆
    case Empress
    /// 权志龙
    case GDragon
    /// 撩妹妆
    case TeaseGirl
    /// 印第安妆
    case Indian
    /// 印度妆
    case India
    /// 萌兔妆
    case CuteRabbit
    /// 大圣妆
    case MonkeyKing
}

/// 人脸变妆类型请求字段
let kIMAGE_EFFECT_DECORATION = "decoration"

// MARK:大头贴
/// 大头贴接口地址
let kPATH_FACE_STICKER = "ptu/ptu_facesticker"

/// 大头贴类型请求字段
let kIMAGE_EFFECT_STICKER = "sticker"

public enum StickerType: Int {
    /// new day
    case NewDay = 1
    /// 欢乐球吃球1
    case HappyBall1
    /// 一路顺风,一路平安
    case Bonvoyage
    /// 享受
    case Enjoy
    /// 小鸡
    case ChickenSpring
    /// 圣诞快乐
    case ChristmasShow
    /// 圣诞雪人
    case ChristmasSnow
    /// 猫咪
    case Cat
    /// 米老鼠
    case Mouse
    /// 猪鼻子
    case Pig
    /// My NAME
    case Comicmn
    /// 可爱北鼻
    case CuteBaby
    /// 信封相框
    case Envolope
    /// 童话相框
    case Fairytale
    /// 晚安
    case GoodNight
    /// 万圣节之夜
    case HalloweenNight
    /// lovely day
    case LovelyDay
    /// 2017
    case Newyear2017
    /// 粉红阳光
    case PinkSunny
    /// KIRA KIRA
    case KIRAKIRA
    /// 欢乐球吃球2
    case HappyBall2
    /// 白雪
    case SnowWhite
    /// super start
    case SuperStar
    /// Wonderful Work
    case WonderfulWork
    /// Cold
    case Cold
    /// 狼人杀守卫
    case Savior
    /// 狼人杀猎人
    case Hunter
    /// 狼人杀预言家
    case Seer
    /// 狼人杀村民
    case Villagers
    /// 狼人杀女巫
    case Witch
    /// 狼人杀狼人
    case Werewolves
}
