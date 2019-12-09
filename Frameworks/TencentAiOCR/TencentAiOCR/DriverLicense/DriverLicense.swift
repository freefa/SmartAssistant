//
//  DriverLicense.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/12/3.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

public enum DriverLicenseType: Int {
    /// 行驶证
    case carLisence
    /// 驾驶证
    case driverLisence
}

open class DriverLicense: GeneralOCR {}
