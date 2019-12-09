//
//  Configuration.swift
//  Log
//
//  Created by Louis.B on 2019/11/16.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

let LOG_OUTPUT = LogConfig.all

enum LogConfig: Int {
    case none = 0
    case console
    case file
    case all
}
