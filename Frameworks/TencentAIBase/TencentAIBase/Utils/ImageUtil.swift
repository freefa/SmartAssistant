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

public extension UIImage {
    /// 压缩图片占用的内存大小,size:MB
    func compressMemoryTo(size: Int) -> UIImage {
        var quality: CGFloat = 1
        var data = self.jpegData(compressionQuality: quality)!
        while data.count > size * 1024 * 1024 {
            quality -= 0.2
            data = self.jpegData(compressionQuality: quality)!
        }
        return UIImage(data: data)!
    }
    
    func pixelData() -> Data {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let width = Int(self.size.width)
        let height = Int(self.size.height)
        let context = CGContext(data: nil,
                                width: width,
                                height: height,
                                bitsPerComponent: 8,
                                bytesPerRow: width * 4,
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
        context?.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
        let rawPointer = (context?.data)!
        return Data(bytes: rawPointer, count: width * height * 4)
    }
    
    func toBase64() -> String {
        let data = self.pngData()
        return data!.base64EncodedString()
    }
}
