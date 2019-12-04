//
//  GeneralOCR.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/12/4.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

open class GeneralOCR: TBaseModel {
    var itemList: [OCRItem]?
    
    private enum CodingKeys: String, CodingKey {
        case angle
        case itemList = "item_list"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        itemList = try container.decode([OCRItem].self, forKey: .itemList)
        try super.init(from: decoder)
    }
}

open class OCRItem: TBaseModel {
    var name: String?
    var value: String?
    var position: [[String : Int]]?
    
    private enum CodingKeys: String, CodingKey {
        case name = "item"
        case value = "itemstring"
        case position = "itemcoord"
        }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        value = try container.decode(String.self, forKey: .value)
        position = try container.decode([[String : Int]].self, forKey: .position)
        try super.init(from: decoder)
    }
}
