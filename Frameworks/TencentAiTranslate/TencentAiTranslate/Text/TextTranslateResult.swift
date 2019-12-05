//
//  TextTranslateResult.swift
//  TencentAiTranslate
//
//  Created by Louis.B on 2019/11/30.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

open class TextTranslateResult: TencentAiBaseModel {
    /// 原字符串
    public var source: String?
    /// 翻译结果
    public var target: String?
    
    public enum KeyMap: String, CodingKey {
        case source = "source_text"
        case target = "target_text"
    }
    
    public required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: KeyMap.self)
            source = try container.decode(String.self, forKey: .source)
            target = try container.decode(String.self, forKey: .target)
        } catch {
            
        }
        try super.init(from: decoder)
    }
}
