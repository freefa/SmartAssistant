//
//  Log.swift
//  Log
//
//  Created by Louis.B on 2019/11/16.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

public func Log(_ content: String, file: String = #file, func: String = #function, line: Int = #line) {
    if LOG_OUTPUT == LogConfig.none {
        return
    }
    
    let fileName = (file as NSString).lastPathComponent
    let msg = "\(logTime())|\(fileName):\(line)| \(content)"
    
    if (LOG_OUTPUT.rawValue & LogConfig.console.rawValue) == LogConfig.console.rawValue {
        print(msg)
    }
    
    if (LOG_OUTPUT.rawValue & LogConfig.file.rawValue) == LogConfig.file.rawValue {
        logToFile(msg)
    }
}

func logToFile(_ content: String) {
    LogFileHelper.shared.logToFile(content)
}

func logTime() -> String {
    let formmater = DateFormatter();
    formmater.dateFormat = "yyyy-MM-dd HH:mm:ss SSS xxxx"
    return formmater.string(from: Date());
}
