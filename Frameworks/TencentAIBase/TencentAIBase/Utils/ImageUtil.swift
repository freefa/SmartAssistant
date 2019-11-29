//
//  ImageUtil.swift
//  TencentAiBase
//
//  Created by Louis.B on 2019/11/29.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation
import UIKit

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
}
