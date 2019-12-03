//
//  DriverLisence.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/12/3.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

public enum DriverLisenceType: Int {
    /// 行驶证
    case carLisence
    /// 驾驶证
    case driverLisence
}

open class DriverLisence: TBaseModel {
    var itemList: [DriverLisenceItem]?
    
    private enum CodingKeys: String, CodingKey {
        case itemList = "item_list"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        itemList = try container.decode([DriverLisenceItem].self, forKey: .itemList)
        try super.init(from: decoder)
    }
}

open class DriverLisenceItem: TBaseModel {
    var name: String?
    var value: String?
    var position: [[String : Int]]?
    var confidence: Float?
    
    private enum CodingKeys: String, CodingKey {
        case name = "item"
        case value = "itemstring"
        case position = "itemcoord"
        case confidence = "itemconf"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        value = try container.decode(String.self, forKey: .value)
        position = try container.decode([[String : Int]].self, forKey: .name)
        confidence = try container.decode(Float.self, forKey: .name)
        try super.init(from: decoder)
    }
}
