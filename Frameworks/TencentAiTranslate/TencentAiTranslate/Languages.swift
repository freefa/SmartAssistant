//
//  Languages.swift
//  TencentAiTranslate
//
//  Created by Louis.B on 2019/12/3.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

// MARK: all languages
public enum TLanguage: String {
    case Chinese = "zh"
    case English = "en"
    case Japanese = "jp"
    case Korean = "kr"
    case French = "fr"
    case Spanish = "es"
    case Italian = "it"
    case German = "de"
    case Turkish = "tr"
    case Russian = "ru"
    case Portuguese = "pt"
    case Vietnamese = "vi"
    case Indonesian = "id"
    case Malaysian = "ms"
    case Thai = "th"
    case Auto = "auto"
}

// MARK: supported language
public let TEXT_TRANSLATE_SUPPORTED: [TLanguage: [TLanguage]]
    = [.Chinese : [.English, .French, .Spanish, .Italian,
                   .German, .Turkish, .Russian, .Portuguese,
                   .Vietnamese, .Indonesian, .Malaysian, .Thai,
                   .Japanese, .Korean],
       .English : [.Chinese, .French, .Spanish, .Italian,
                   .German, .Turkish, .Russian, .Portuguese,
                   .Vietnamese, .Malaysian, .Thai],
       .French : [.Chinese, .English, .Spanish, .Italian,
                  .German, .Turkish, .Russian, .Portuguese],
       .Spanish : [.Chinese, .English, .French, .Italian,
                   .German, .Turkish, .Russian, .Portuguese],
       .Italian : [.Chinese, .English, .French, .Spanish,
                   .German, .Turkish, .Russian, .Portuguese],
       .German : [.Chinese, .English, .French, .Spanish,
                  .Italian, .Turkish, .Russian, .Portuguese],
       .Turkish : [.Chinese, .English, .French, .Spanish,
                   .Italian, .German, .Russian, .Portuguese],
       .Russian : [.Chinese, .English, .French, .Spanish,
                   .Italian, .German, .Turkish, .Portuguese],
       .Portuguese : [.Chinese, .English, .French, .Spanish,
                      .Italian, .German, .Turkish, .Russian],
       .Vietnamese : [.Chinese, .English],
       .Indonesian : [.Chinese, .English],
       .Malaysian : [.Chinese, .English],
       .Thai : [.Chinese, .English],
       .Japanese : [.Chinese],
       .Korean : [.Chinese]
]

public let IMG_TRANSLATE_SUPPORTED: [TLanguage : [TLanguage]]
    = [.English : [.Chinese],
       .Chinese : [.English, .Japanese, .Korean],
       .Japanese : [.Chinese],
       .Korean : [.Chinese],]

public let LANGUAGE_DISPLAY_MAP: [TLanguage : String] = [
    .Chinese: "简体中文",
    .English: "英文",
    .French: "法语",
    .Spanish: "西班牙语",
    .Italian: "意大利语",
    .German: "德语",
    .Turkish: "土耳其语",
    .Russian: "俄罗斯语",
    .Portuguese: "葡萄牙语",
    .Vietnamese: "越南语",
    .Indonesian: "印度尼西亚语",
    .Malaysian: "马来西亚语",
    .Thai: "泰语",
    .Japanese: "日语",
    .Korean: "韩语"
]
