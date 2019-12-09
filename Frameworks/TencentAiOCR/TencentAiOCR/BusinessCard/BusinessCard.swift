//
//  BusinessCard.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/12/3.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

open class BusinessCard: GeneralOCR {
    var angle: String?
    
    private enum CodingKeys: String, CodingKey {
        case angle
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        angle = try container.decode(String.self, forKey: .angle)
        try super.init(from: decoder)
    }
}

