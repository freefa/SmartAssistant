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
public let BYTES_PER_PIXEL: CGFloat = 4
public let BINARY_UNIT: CGFloat = 1024.0

public extension UIImage {
    /// 压缩图片到接口支持的最大大小
    func compressForBase64Encoding(memory: Float = IMAGE_MEMORY_SIZE) -> UIImage {
        if self.shouldCompressSize(memory: memory) {
            let size = self.sizeForMemory(memory)
            let compressed = self.compressToSize(maxSize: size)
            TLog.d("compressed final memory: \(compressed.size.width * compressed.size.height * BYTES_PER_PIXEL / BINARY_UNIT / BINARY_UNIT) MB")
            return compressed
        }
        return self
    }
    
    /// 计算图片占用的内存是否超过指定大小(适用于一个像素占4个字节的图片,如RGBA/ARGB等)
    /// - Parameter memory: 指定内存大小(MB)
    func shouldCompressSize(memory: Float) -> Bool {
        let size = self.size.width * self.size.height * BYTES_PER_PIXEL / BINARY_UNIT / BINARY_UNIT
        TLog.d("source image memory is: \(size) MB")
        return Float(size) > memory
    }
    
    /// 根据自身宽高比计算压缩到指定内存大小后的图片宽高
    /// - Parameter memory: 指定内存大小(MB)
    func sizeForMemory(_ memory: Float) -> CGSize {
        TLog.d("source image size: {\(self.size.width), \(self.size.height)}")
        TLog.d("source image memory: \(self.size.width * self.size.height * BYTES_PER_PIXEL / BINARY_UNIT / BINARY_UNIT) MB")
        let baseMemory = Double(self.size.width * self.size.height * BYTES_PER_PIXEL / BINARY_UNIT / BINARY_UNIT) / Double(memory)
        TLog.d("baseMemory : \(baseMemory)")
        let scale = CGFloat(sqrt(ceil(baseMemory * 100.0) / 100.0))
        TLog.d("scale: \(scale)")
        let size = CGSize(width: floor(self.size.width / scale), height: floor(self.size.height / scale))
        TLog.d("calculated image size: {\(size.width), \(size.height)}")
        TLog.d("calculated memory: \(size.width * size.height * BYTES_PER_PIXEL / BINARY_UNIT / BINARY_UNIT) MB")
        return size
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
    
    func toBase64() -> String {
        let data = self.pngData()
        return data!.base64EncodedString()
    }
}
