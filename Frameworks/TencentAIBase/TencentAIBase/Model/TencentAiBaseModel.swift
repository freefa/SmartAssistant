//
//  TencentAiBaseModel.swift
//  TencentAiBase
//
//  Created by Louis.B on 2019/11/29.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

open class TencentAiBaseModel: Codable {
    public init() {}
}

extension Decodable where Self: TencentAiBaseModel {
    public static func decodeFrom(data: Data) -> (success: Bool, model: Self?) {
        let dict = try? JSONSerialization .jsonObject(with: data, options: .allowFragments)
        if let info = dict as? Dictionary<String, Any> {
            if let code = info[kRESP_CODE] as? Int, code == TErrorCode.success.rawValue {
                let resultInfo = info[kRESP_DATA] as! Dictionary<String, Any>
                let resultData = try! JSONSerialization.data(withJSONObject: resultInfo, options: .fragmentsAllowed)
                do {
                    let model = try JSONDecoder().decode(Self.self, from: resultData)
                    return (true, model)
                } catch {
                    TLog.d("decode json to model error: \(error.localizedDescription)")
                    return (false, nil)
                }
            } else {
                return (false, nil)
            }
        }
        return (false, nil)
    }
}
