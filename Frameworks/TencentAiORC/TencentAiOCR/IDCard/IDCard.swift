//
//  IDCard.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/11/29.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

open class IDCard: TBaseModel {
    public var name: String?
    public var gender: String?
    public var nation: String?
    public var birthday: String?
    public var address: String?
    public var id: String?
    public var validDate: String?
    public var authority: String?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case gender = "sex"
        case nation
        case birthday = "birth"
        case address
        case id
        case validDate = "valid_date"
        case authority
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        gender = try container.decode(String.self, forKey: .gender)
        nation = try container.decode(String.self, forKey: .nation)
        birthday = try container.decode(String.self, forKey: .birthday)
        address = try container.decode(String.self, forKey: .address)
        id = try container.decode(String.self, forKey: .id)
        validDate = try container.decode(String.self, forKey: .validDate)
        authority = try container.decode(String.self, forKey: .authority)
        try super.init(from: decoder)
    }
}
