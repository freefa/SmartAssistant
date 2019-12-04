//
//  OCRConstants.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/12/3.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

// MARK: 图片参数key
public let kIMG_PARAM = "image"
public let kCOMMON_TYPE = "type"

// MARK: 身份证
let TPATH_IDCARD_ORC = "ocr/ocr_idcardocr"
public let kIMG_ID_CARD_TYPE = "card_type"

public enum IDCardType: Int {
    /// 正面
    case front
    /// 反面
    case back
}

// MARK: 名片
let TPATH_BUSINESS_CARD_OCR = "ocr/ocr_bcocr"

// MARK: 行驶证/驾驶证
let kPATH_DRIVER_LISENCE_OCR = "ocr/ocr_driverlicenseocr"

// MARK: 车牌号
let kPATH_NUMBER_PLATE_OCR = "ocr/ocr_plateocr"

// MARK: 银行卡
let kPATH_BANK_CARD_OCR = "ocr/ocr_creditcardocr"

// MARK: 营业执照
let kPATH_BUSINESS_LICENSE_OCR = "ocr/ocr_bizlicenseocr"


