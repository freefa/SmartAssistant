//
//  LBToast.swift
//  LBToast
//
//  Created by Louis.B on 2019/12/6.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation
@_exported import UIKit
@_exported import Log

public typealias ShowingTime = Double

/// 默认显示2秒
let DEFAULT_DURATION: ShowingTime = 2
/// 每10个字增加1秒显示时长
let MSG_LENGTH_UNIT = 10
/// 最长显示5秒
let MAX_DURATION: ShowingTime = 3

public struct LBToast {
    public static func show(_ message: String,
                            in view: UIView = UIApplication.shared.keyWindow!,
                            image: UIImage? = nil,
                            disappearAfer: ShowingTime? = nil) {
        var duration = disappearAfer
        if duration == nil {
            duration = getDuration(message)
        }
        let toast = LBToastView.create(message, on: view)
        toast.showThenDisappear(duration: duration!)
    }
    
    static func getDuration(_ message: String) -> ShowingTime {
        var duration = DEFAULT_DURATION
        var count = message.count - MSG_LENGTH_UNIT
        while count > 0 {
            duration += 1
            count -= MSG_LENGTH_UNIT
        }
        return duration > MAX_DURATION ? MAX_DURATION : duration
    }
    
    public static func showLoading(_ message: String? = nil,
                                   in view: UIView = UIApplication.shared.keyWindow!,
                                   style: LoadingAnimateStyle? = nil) {
        let loadingView = LBLoadingView.create(message, superView: view, style: style)
        loadingView.show()
    }
    
    public static func hideLoading(in view: UIView = UIApplication.shared.keyWindow!) {
        for subview in view.subviews {
            if let loadingView = subview as? LBLoadingView {
                loadingView.hide()
                break
            }
        }
    }
}
