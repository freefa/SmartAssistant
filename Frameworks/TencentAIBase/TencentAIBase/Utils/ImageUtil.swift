//
//  ImageUtil.swift
//  TencentAiBase
//
//  Created by Louis.B on 2019/11/29.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

/// 图片宽高不超过512(512 * 512的图片占用内存大小为1MB)
public let IMAGE_SIZE_MAX = 512
/// 图片占用的最大内存限制1MB
public let IMAGE_MEMORY_SIZE: Float = 1
/// 1MB的字节数
public let BYTES_PER_MB: Float = 1 * 1024 * 1024

public extension UIImage {
    /// 压缩图片到接口支持的最大大小
    func compressForBase64Encoding() -> UIImage {
        let resized = self.compressToSize(maxSize: CGSize(width: IMAGE_SIZE_MAX, height: IMAGE_SIZE_MAX))
        let compressed = resized.compressToMemery(memory: IMAGE_MEMORY_SIZE)
        return compressed
    }
    
    /// 按照宽高比例压缩至指定尺寸
    /// - Parameter maxSize: 最大尺寸
    func compressToSize(maxSize: CGSize) -> UIImage {
        if self.size.width <= maxSize.width, self.size.height <= maxSize.height {
            TLog.d("image does not need compress size")
            return self
        }
        var width = self.size.width
        var height = self.size.height
        let scale = width / height
        if width > maxSize.width {
            width = maxSize.width
            height = width / scale
            TLog.d("compress width: {\(width), \(height)}")
        }
        
        if height > maxSize.height {
            height = maxSize.height
            width = height * scale
            TLog.d("compress height: {\(width), \(height)}")
        }
        let targetSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(targetSize)
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let resized = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        TLog.d("resized image: {\(resized.size.width), \(resized.size.height)}")
        return resized
    }
    
    /// 压缩图片到指定内存大小(质量压缩,如果压缩比太高要先进行尺寸压缩再调用此方法)
    /// - Parameter memory: 内存大小:MB
    func compressToMemery(memory: Float) -> UIImage {
        var quality: CGFloat = 1.0
        let maxBytes = Int(memory * BYTES_PER_MB)
        var data = self.jpegData(compressionQuality: quality)!
        if data.count <= maxBytes {
            TLog.d("image does not need to compress memory")
            return self
        }
        
        while data.count > maxBytes {
            quality -= 0.1
            data = self.jpegData(compressionQuality: quality)!
        }
        TLog.d("compressed memory to: \(Float(data.count) / 1024.0 / 1024.0) MB")
        return UIImage(data: data)!
    }
    
    func toBase64() -> String {
        let data = self.pngData()
        return data!.base64EncodedString()
    }
}
