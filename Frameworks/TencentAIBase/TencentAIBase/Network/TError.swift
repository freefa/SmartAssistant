//
//  Resultswift.swift
//  TencentAiBase
//
//  Created by Louis.B on 2019/11/29.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

public let HTTP_RESP_CODE_SUCCESS = 200

public struct TError {
    public var code: Int
    public var description: String
    
    public init(code: Int, description: String) {
        self.code = code
        self.description = description
    }
}

public enum TErrorCode: Int {
    /// system error code < 0
    
    /// system busy, please try again later
    case systemBusy = -30
    /// business success
    case success
    /// qps超过限制
    case outOfQps = 9
    /// 参数非法,请检查请求参数是否符合要求
    case illegalParam = 4096
    /// 应用不存在,请检查app_id是否有效的应用标识（AppId）
    case appIdNotFound = 12289
    /// 素材不存在,请检查app_id对应的素材模版id
    case templateNotFound = 12801
    /// 素材ID与应用ID不匹配,请检查app_id对应的素材模版id
    case templateNotMatch = 12802
    /// 缺少app_id参数,请检查请求中是否包含有效的app_id参数
    case appIdMissing = 16385
    /// 缺少time_stamp参数,请检查请求中是否包含有效的time_stamp参数
    case timestampMissing = 16386
    /// 缺少nonce_str参数,请检查请求中是否包含有效的nonce_str参数
    case nonceStrMissing = 16387
    /// 请求签名无效,请检查请求中的签名信息（sign）是否有效
    case signatureInvalid = 16388
    /// 缺失API权限,请检查应用是否勾选当前API所属接口的权限
    case apiDenied = 16389
    /// time_stamp参数无效,请检查time_stamp距离当前时间是否超过5分钟
    case timestampInvalid = 16390
    /// 同义词识别结果为空,请尝试更换文案
    case synonymsUnrecognized = 16391
    /// 专有名词识别结果为空,请尝试更换文案
    case ProperNounUnrecognized = 16392
    /// 意图识别结果为空,请尝试更换文案
    case intentionUnrecognized = 16393
    /// 闲聊返回结果为空,请联系客服反馈问题
    case chatMsgUnrecognized = 16394
    /// 图片格式非法,请检查图片格式是否符合API要求
    case illegalImageFormat = 16396
    /// 图片体积过大,请检查图片大小是否超过API限制
    case imageTooLarge = 16397
    /// 图片没有人脸,请检查图片是否包含人脸
    case faceNotFound = 16402
    /// 相似度错误,请联系客服反馈问题
    case similarityError = 16403
    /// 人脸检测失败,请联系客服反馈问题
    case faceUnrecognized = 16404
    /// 图片解码失败,请联系客服反馈问题
    case imageDecodeFailed = 16405
    /// 特征处理失败,请联系客服反馈问题
    case featureProcessFailed = 16406
    /// 提取轮廓错误,请联系客服反馈问题
    case profileCollectFailed = 16407
    /// 提取性别错误,请联系客服反馈问题
    case genderFailed = 16408
    /// 提取表情错误,请联系客服反馈问题
    case faceExpressionFailed = 16409
    /// 提取年龄错误,请联系客服反馈问题
    case ageFailed = 16410
    /// 提取姿态错误,请联系客服反馈问题
    case postureFaled = 16411
    /// 提取眼镜错误,请联系客服反馈问题
    case glassFailed = 16412
    /// 提取魅力值错误,请联系客服反馈问题
    case charismaFailed = 16413
    /// 语音合成失败,请联系客服反馈问题
    case speechSynthesisFailed = 16414
    /// 图片为空,请检查图片是否正常
    case imageEmpty = 16415
    /// 个体已存在,请检查个体是否已存在
    case individualAlreadExist = 16416
    /// 个体不存在,请检查个体是否不存在
    case individualNotFound = 16417
    /// 人脸不存在,请检查人脸是否不存在
    case faceNotExist = 16418
    /// 分组不存在,请检查分组是否不存在
    case groupNotFound = 16419
    /// 分组列表不存在,请检查分组列表是否不存在
    case groupListNotFound = 16420
    /// 人脸个数超过限制,请检查是否超过系统限制
    case faceOutOfLimit = 16421
    /// 个体个数超过限制,请检查是否超过系统限制
    case individualOutOfLimit = 16422
    /// 组个数超过限制,请检查是否超过系统限制
    case groupOutOfLimit = 16423
    /// 对个体添加了几乎相同的人脸,请检查个体已添加的人脸
    case sameFaceToindividual = 16424
    /// 无效的图片格式,请检查图片格式是否符号API要求
    case invalidImageFormat = 16425
    /// 图片模糊度检测失败,请联系客服反馈问题
    case blurFailed = 16426
    /// 美食图片检测失败,请联系客服反馈问题
    case foodImageFailed = 16427
    /// 提取图像指纹失败,请联系客服反馈问题
    case imageFingerprintFailed = 16428
    /// 图像特征比对失败,请联系客服反馈问题
    case imageCompareFailed = 16429
    /// OCR照片为空,请检查待处理图片是否为空
    case ocrImageEmpty = 16430
    /// OCR识别失败,请尝试更换带有文字的图片
    case ocrUnrecognized = 16431
    /// 输入图片不是身份证,请检查图片是否为身份证
    case inputNotIDCard = 16432
    /// 名片无足够文本,请检查名片是否正常
    case cardTextNotEnough = 16433
    /// 名片文本行倾斜角度太大,请检查名片是否正常
    case cardTextItalic = 16434
    /// 名片模糊,请检查名片是否正常
    case blurredCard = 16435
    /// 名片姓名识别失败,请尝试更换姓名显示清晰的名片图片
    case cardNameUnrecognized = 16436
    /// 名片电话识别失败,请尝试更换电话显示清晰的名片图片
    case cardNumberUnrecognized = 16437
    /// 图像为非名片图像,请尝试更换有效的名片图片
    case inputNotCard = 16438
    /// 检测或者识别失败,请联系客服反馈问题
    case unrecognized = 16439
    /// 未检测到身份证,请对准边框(避免拍摄时倾角和旋转角过大、摄像头)
    case IDCardNotDetected = 16440
    /// 请使用第二代身份证件进行扫描,请使用第二代身份证进行处理
    case IDCardNotV2 = 16441
    /// 不是身份证正面照片,请使用带证件照的一面进行处理
    case IDCardNotFront = 16442
    /// 不是身份证反面照片,请使用身份证反面进行进行处理
    case IDCardNotBack = 16443
    /// 证件图片模糊,请确保证件图片清晰
    case blurredCertificate = 16444
    /// 请避开灯光直射在证件表面,请避开灯光直射在证件表面
    case certificateTooLight = 16445
    /// 行驾驶证OCR识别失败,请尝试更换有效的行驾驶证图片
    case driverLisenceFailed = 16446
    /// 通用OCR识别失败,请尝试更换带有文字的图片
    case ocrFailed = 16447
    /// 银行卡OCR预处理错误,请联系客服反馈问题
    case bankCardPreProcFailed = 16448
    /// 银行卡OCR识别失败,请尝试更换有效的银行卡图片
    case bankCardFailed = 16449
    /// 营业执照OCR预处理失败,请联系客服反馈问题
    case licenseProProcFailed = 16450
    /// 营业执照OCR识别失败,请联系客服反馈问题
    case licenseFailed = 16451
    /// 意图识别超时,请联系客服反馈问题
    case intentionTimeout = 16452
    /// 闲聊处理超时,请联系客服反馈问题
    case chatMsgTimeout = 16453
    /// 语音识别解码失败,请检查语音参数是否正确编码
    case speechRecognizeFailed = 16454
    /// 语音过长或空,请检查语音参数是否正确编码或者长度是否合法
    case speechToLongOrEmpty = 16455
    /// 翻译引擎失败,请联系客服反馈问题
    case translateEngineFailed = 16456
    /// 不支持的翻译类型,请检查翻译类型参数是否合法
    case translateUnsupported = 16457
    /// 输入图片与识别场景不匹配,请检查场景参数是否正确，所传图片与场景是否匹配
    case imageSceneNotMatch = 16460
    /// 识别结果为空,当前图片无法匹配已收录的标签,请尝试更换图片
    case recognizedNothing = 16461
    /// 多人脸检测识别结果为空,图片中识别不出人脸,请尝试更换图片
    case multiFaceNothing = 16462
    /// 跨年龄人脸识别出错,请尝试更换有人脸的图片
    case acrossAgeFailed = 16467
    /// 跨年龄人脸识别结果为空,源图片与目标图片中识别不出匹配的人脸,请尝试更换图片
    case acrossAgeNothing = 16468
    /// 音频鉴黄识别出错,请确保音频地址能正常下载音频,尝试更换音频
    case audioPornFailed = 16472
    
    // MARK: 自定义错误码
    case unsupportedTranslate = 100001
}
