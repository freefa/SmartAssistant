//
//  BusinessCard.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/12/3.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

open class BusinessCard: TBaseModel {
    var angle: String?
    var itemList: [BusinessCardItem]?
    
    private enum CodingKeys: String, CodingKey {
        case angle
        case itemList = "item_list"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        angle = try container.decode(String.self, forKey: .angle)
        itemList = try container.decode([BusinessCardItem].self, forKey: .itemList)
        try super.init(from: decoder)
    }
}

open class BusinessCardItem: TBaseModel {
    var name: String?
    var value: String?
    var positionInfo: [[String : Int]]?
//    var words: [BusinessCardWord]?
    
    private enum CodingKeys: String, CodingKey {
        case name = "item"
        case value = "itemstring"
        case positionInfo = "itemcoord"
//        case words
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        value = try container.decode(String.self, forKey: .value)
        positionInfo = try container.decode([[String : Int]].self, forKey: .positionInfo)
//        words = try container.decode([BusinessCardWord].self, forKey: .words)
        try super.init(from: decoder)
    }
}

//open class BusinessCardWord: TBaseModel {
//    var character: String?
//    var confidence: String?
//}
