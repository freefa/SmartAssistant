//
//  TLog.swift
//  TencentAIBase
//
//  Created by Louis.B on 2019/11/28.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation
import Log

public enum TLog {
    public static func d(_ string: String, file: String = #file, func: String = #function, line: Int = #line) {
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        let msg = "\(nowTimeString())|TencentAI|DEBUG|\(fileName):\(line)| \(string)"
        Log("\(msg)")
        #endif
    }
    
    static func nowTimeString() -> String {
        let formmater = DateFormatter();
        formmater.dateFormat = "yyyy-MM-dd HH:mm:ss SSS xxxx"
        return formmater.string(from: Date());
    }

}
