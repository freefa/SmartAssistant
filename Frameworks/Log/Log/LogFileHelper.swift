//
//  LogFileHelper.swift
//  Log
//
//  Created by Louis.B on 2019/12/9.
//  Copyright © 2019 lubiao. All rights reserved.
//

import Foundation

let LOG_FILE_QUEUE = "log_file_queue"
let MAX_LOG_FILE = 10
let MAX_SINGLE_LOG_FILE_SIZE: UInt64 = (10 * 1024 * 1024) // 10MB

fileprivate let LOG_FILE_LOCK = NSLock()

public class LogFileHelper {
    public static let shared = instance
    
    private static let instance = LogFileHelper()
    
    private var fileHandle: FileHandle?
    
    private var currentPath: String?
    
    private let logFileQueue = DispatchQueue.init(label: LOG_FILE_QUEUE)
    
    private init() {
        
    }
    
    public func logToFile(_ content: String) {
        logFileQueue.async {
            if let fileHandle = self.getFileHandle(path: FileManager.getWritteableLogFile()) {
                let string = content + "\n"
                if let data = string.data(using: .utf8) {
                    fileHandle.write(data)
                }
            }
        }
    }
    
    func getFileHandle(path: String) -> FileHandle? {
        if self.currentPath != nil, self.currentPath! != path {
            self.fileHandle!.closeFile()
            self.fileHandle = nil
        }
        
        if self.fileHandle == nil {
            do {
                self.currentPath = path
                let url = URL(string: path)!
                self.fileHandle = try FileHandle(forUpdating: url)
            } catch {
                print(error.localizedDescription)
            }
        }
        self.fileHandle?.seekToEndOfFile()
        return self.fileHandle
    }
}

extension FileManager {
    
    static func getWritteableLogFile() -> String {
        LOG_FILE_LOCK.lock()
        let filePath = self.logFile()
        LOG_FILE_LOCK.unlock()
        return filePath
    }
    
    static func logFileDirectory() -> String {
        let dir = NSHomeDirectory() + "/tmp/log/"
        var isDir = ObjCBool(false)
        if !FileManager.default.fileExists(atPath: dir, isDirectory: &isDir) || !isDir.boolValue {
            do {
                try FileManager.default.createDirectory(atPath: dir,
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
        return dir
    }
    
    static func logFile() -> String {
        let manager = FileManager.default
        var fileNumber = 1
        var lastLogFile = self.getLatestLogFile()
        if !manager.fileExists(atPath: lastLogFile) {
            manager.createFile(atPath: lastLogFile, contents: nil, attributes: nil)
        }
        do {
            fileNumber = Int(lastLogFile.split(separator: "/").last!.split(separator: ".").first!)!
            let attr = try manager.attributesOfItem(atPath: lastLogFile)
            let size = attr[FileAttributeKey.size] as! UInt64
            if size > MAX_SINGLE_LOG_FILE_SIZE {
                fileNumber += 1
                if fileNumber > MAX_LOG_FILE {
                    fileNumber = 1
                }
                lastLogFile = self.logFileDirectory() + String(fileNumber) + ".log"
                if manager.fileExists(atPath: lastLogFile) {
                    try manager.removeItem(atPath: lastLogFile)
                }
                manager.createFile(atPath: lastLogFile, contents: nil, attributes: nil)
            }
        } catch {
            print(error.localizedDescription)
        }
        return lastLogFile
    }
    
    static func getLatestLogFile() -> String {
        let dir = self.logFileDirectory()
        var latestFile = dir + "1.log"
        do {
            let manager = FileManager.default
            let files = try manager.contentsOfDirectory(atPath: dir)
            let sortedFiles = try files.sorted { (file1, file2) -> Bool in
                if file1.hasSuffix(".log"), file2.hasSuffix(".log") {
                    let path1 = dir + file1
                    let attr1 = try manager.attributesOfItem(atPath: path1)
                    let date1 = attr1[FileAttributeKey.creationDate] as! Date
                    let path2 = dir + file2
                    let attr2 = try manager.attributesOfItem(atPath: path2)
                    let date2 = attr2[FileAttributeKey.creationDate] as! Date
                    return  date1 < date2
                }
                return true
            }
            if let last = sortedFiles.last {
                latestFile = dir + last
            }
        } catch {
            print(error.localizedDescription)
        }
        return latestFile
    }
}
