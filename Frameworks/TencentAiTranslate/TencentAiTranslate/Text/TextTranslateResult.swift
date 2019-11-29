//
//  TextTranslateResult.swift
//  TencentAiTranslate
//
//  Created by Louis.B on 2019/11/30.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

open class TextTranslateResult: TBaseModel {
    /// 原字符串
    public var source: String?
    /// 翻译结果
    public var target: String?
}
