//
//  LBToastView.swift
//  LBToast
//
//  Created by Louis.B on 2019/12/6.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

/// toast距离View底部的距离
let BOTTOM_PADDING: CGFloat = 64
/// toast距离view左右边距
let HORIZONTAL_PADDING: CGFloat = 30
/// 文字与toast背景边距
let HORIZONTAL_INNER_PADDING: CGFloat = 12
/// 文字与toast背景上下边距
let VERTICAL_INNER_PADDING: CGFloat = 8

/// 圆角大小
let TOAST_CORNER_RADIUS: CGFloat = 6
/// toast最小高度
let MIN_HEIGHT: CGFloat = TOAST_CORNER_RADIUS * 2
/// toast字体
let DEFAULT_FONT = UIFont.systemFont(ofSize: 16)

let TOAST_LABEL_TAG = 101
let TOAST_IMAGE_TAG = 102

open class LBToastView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    static func create(_ message: String, on superView: UIView, image: UIImage? = nil) -> LBToastView {
        let size = getSize(message, in: superView, image: image)
        Log("toast size: {\(size.width), \(size.height)}")
        let toast = LBToastView.init(frame: .zero)
        toast.translatesAutoresizingMaskIntoConstraints = false
        toast.backgroundColor = UIColor.black.withAlphaComponent(0)
        toast.layer.cornerRadius = TOAST_CORNER_RADIUS
        let label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.tag = TOAST_LABEL_TAG
        label.font = DEFAULT_FONT
        label.textColor = UIColor.white
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .natural
        label.numberOfLines = 0
        label.text = message
        toast.addSubview(label)
        label.sizeToFit()
        // TODO: imageView
        superView.addSubview(toast)
        toast.setupConstraints(on: superView, size: size)
        return toast
    }
    
    private static func getSize(_ message: String, in view: UIView, image: UIImage? = nil) -> CGSize {
        let maxWidth = view.bounds.size.width - HORIZONTAL_PADDING * 2
        let maxSize = CGSize(width: maxWidth, height: view.bounds.size.height)
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .byWordWrapping
        style.alignment = .natural
        let size = message.boundingRect(with: maxSize,
                                        options: .usesLineFragmentOrigin,
                                        attributes: [NSAttributedString.Key.font : DEFAULT_FONT,
                                                     NSAttributedString.Key.paragraphStyle : style],
                                        context: nil).size
        
        // TODO: 计算图片
        
        return CGSize(width: ceil(size.width + HORIZONTAL_INNER_PADDING * 2),
                      height: ceil(size.height + VERTICAL_INNER_PADDING * 2))
    }
    
    private func setupConstraints(on superView: UIView, size: CGSize) {
        // constraints beteewn toast and superView
        let label = self.viewWithTag(TOAST_LABEL_TAG) as Any
        var vfl = "H:[self(\(size.width))]"
        let views = ["self" : self as Any,
                     "label" : label]
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: vfl,
                                                         metrics: nil,
                                                         views: views)
        superView.addConstraints(constraints)
        superview?.addConstraint(NSLayoutConstraint.init(item: self, attribute: .centerX, relatedBy: .equal, toItem: superView, attribute: .centerX, multiplier: 1.0, constant: 0))
        
        vfl = "V:[self(\(size.height))]-\(BOTTOM_PADDING)-|"
        constraints = NSLayoutConstraint.constraints(withVisualFormat: vfl,
                                                     metrics: nil,
                                                     views: views)
        superView.addConstraints(constraints)
        
        vfl = "H:[label(\(size.width - HORIZONTAL_INNER_PADDING * 2))]"
        constraints = NSLayoutConstraint.constraints(withVisualFormat: vfl,
                                                     metrics: nil,
                                                     views: views)
        self.addConstraints(constraints)
        
        vfl = "V:[label(\(size.height - VERTICAL_INNER_PADDING * 2))]"
        constraints = NSLayoutConstraint.constraints(withVisualFormat: vfl,
                                                     metrics: nil,
                                                     views: views)
        self.addConstraints(constraints)
        
        self.addConstraint(NSLayoutConstraint.init(item: label,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .centerX,
                                                   multiplier: 1,
                                                   constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: label,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .centerY,
                                                   multiplier: 1,
                                                   constant: 0))
    }
    
    func showThenDisappear(duration: ShowingTime) {
        self.superview?.setNeedsLayout()
        self.superview?.layoutIfNeeded()
        Log("toast frame: {\(self.frame.origin.x), \(self.frame.origin.y), \(self.frame.size.width), \(self.frame.size.height)}")
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        }) { (finish) in
            guard finish else { return }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundColor = UIColor.black.withAlphaComponent(0)
                }) { (complete) in
                    guard let _ = self.superview else { return }
                    self.removeFromSuperview()
                }
            }
        }
    }
}
