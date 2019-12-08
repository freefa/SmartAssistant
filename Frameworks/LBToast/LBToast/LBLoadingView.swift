//
//  LBLoadingView.swift
//  LBToast
//
//  Created by Louis.B on 2019/12/8.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import UIKit

let MIN_LOADING_VIEW_WIDTH: CGFloat = 80
let MIN_LOADING_VIEW_HEIGHT = MIN_LOADING_VIEW_WIDTH
let MIN_LOADING_PADDING_H: CGFloat = 60
let LOADING_VIEW_INNER_PADDING_H: CGFloat = 10
let LOADING_VIEW_INNER_PADDING_V: CGFloat = 10
let LOADING_VIEW_CORNER_RADIUS: CGFloat = 6
let LOADING_MESSAGE_FONT = UIFont.systemFont(ofSize: 16)

let LOADING_ANIMATE_VIEW_TAG = 101
let LOADING_MESSAGE_LABEL_TAG = 102

protocol LoadingSizeGetter {}

public enum LoadingAnimateStyle {
    case `default`
}


class LBLoadingView: UIView {
    var indicator: UIView?
    var indicatorSize: CGSize?
    
    var label: UIView?
    var labelSize: CGSize?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public static func create(_ message: String?, superView: UIView, style: LoadingAnimateStyle? = nil) -> LBLoadingView {
        let loadingView = LBLoadingView.init(frame: .zero)
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.layer.cornerRadius = LOADING_VIEW_CORNER_RADIUS
        superView.addSubview(loadingView)
        
        loadingView.setupMessage(message)
        loadingView.setupLoadingView(style: style)
        
        loadingView.setupConstraints()
        return loadingView
    }
    
    func show() {
        let animateView = indicator as! UIActivityIndicatorView
        animateView.startAnimating()
        UIView.animate(withDuration: 0.25) {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
        }) { (finish) in
            let animateView = self.indicator as! UIActivityIndicatorView
            animateView.stopAnimating()
            if self.superview != nil {
                self.removeFromSuperview()
            }
        }
    }
    
    func setupLoadingView(style: LoadingAnimateStyle?) {
        var animateSize = CGSize()
        switch style {
        default:
            indicator = UIActivityIndicatorView.init(style: .whiteLarge)
            indicator?.translatesAutoresizingMaskIntoConstraints = false
            animateSize = indicator!.bounds.size
        }
        let animateView = indicator!
        self.addSubview(animateView)
        Log("animateView size: {\(animateSize.width), \(animateSize.height)}")
        indicatorSize = animateSize
        
        var vfl = "H:[animateView(\(animateSize.width))]"
        let views = ["animateView" : animateView as Any]
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: vfl,
                                                         metrics: nil,
                                                         views: views)
        self.addConstraints(constraints)
        self.addConstraint(NSLayoutConstraint.init(item: animateView,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .centerX,
                                                   multiplier: 1,
                                                   constant: 0))
        if labelSize != nil {
            vfl = "V:|-\(LOADING_VIEW_INNER_PADDING_V)-[animateView(\(animateSize.height))]"
            constraints = NSLayoutConstraint.constraints(withVisualFormat: vfl,
                                                         metrics: nil,
                                                         views: views)
            self.addConstraints(constraints)
        } else {
            self.addConstraint(NSLayoutConstraint.init(item: animateView,
                                                       attribute: .centerY,
                                                       relatedBy: .equal,
                                                       toItem: self,
                                                       attribute: .centerY,
                                                       multiplier: 1,
                                                       constant: 0))
        }
    }
    
    func setupMessage(_ message: String?) {
        guard let _ = message else { return }
        
        let maxWidth = self.superview!.bounds.size.width - MIN_LOADING_PADDING_H * 2 - LOADING_VIEW_INNER_PADDING_H * 2
        let maxSize = CGSize(width: maxWidth, height: self.superview!.bounds.size.height)
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .byWordWrapping
        style.alignment = .center
        var size = message!.boundingRect(with: maxSize,
                                         options: .usesLineFragmentOrigin,
                                         attributes: [NSAttributedString.Key.font : LOADING_MESSAGE_FONT,
                                                      NSAttributedString.Key.paragraphStyle : style],
                                         context: nil).size
        size = CGSize(width: ceil(size.width), height: ceil(size.height))
        let msgLabel = UILabel.init()
        msgLabel.translatesAutoresizingMaskIntoConstraints = false
        msgLabel.tag = LOADING_MESSAGE_LABEL_TAG
        msgLabel.backgroundColor = UIColor.clear
        msgLabel.font = LOADING_MESSAGE_FONT
        msgLabel.lineBreakMode = .byWordWrapping
        msgLabel.textAlignment = .center
        msgLabel.numberOfLines = 0
        msgLabel.textColor = UIColor.white
        msgLabel.text = message
        self.addSubview(msgLabel)
        label = msgLabel
        labelSize = CGSize(width: ceil(size.width), height: ceil(size.height))
        
        var vfl = "[label(\(labelSize!.width))]"
        let views = ["label" : label as Any]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: vfl,
                                                           metrics: nil,
                                                           views: views))
        self.addConstraint(NSLayoutConstraint.init(item: label as Any,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .centerX,
                                                   multiplier: 1,
                                                   constant: 0))
        vfl = "V:[label(\(labelSize!.height))]-\(LOADING_VIEW_INNER_PADDING_V)-|"
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: vfl,
                                                           metrics: nil,
                                                           views: views))
    }
    
    func setupConstraints(_ message: String? = nil) {
        var width = indicatorSize!.width
        var height = indicatorSize!.height
        if labelSize != nil {
            width = max(width, labelSize!.width)
            height += labelSize!.height
        }
        width += LOADING_VIEW_INNER_PADDING_H * 2
        height += LOADING_VIEW_INNER_PADDING_V * 3
        if width < MIN_LOADING_VIEW_WIDTH {
            width = MIN_LOADING_VIEW_WIDTH
        }
        if height < MIN_LOADING_VIEW_HEIGHT {
            height = MIN_LOADING_VIEW_HEIGHT
        }
        Log("LoadingView size: {\(ceil(width)), \(ceil(height))}")
        let views = ["self" : self as Any]
        var vfl = "H:[self(\(ceil(width)))]"
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: vfl,
                                                         metrics: nil,
                                                         views: views)
        self.superview?.addConstraints(constraints)
        self.superview?.addConstraint(NSLayoutConstraint.init(item: self,
                                                              attribute: .centerX,
                                                              relatedBy: .equal,
                                                              toItem: self.superview,
                                                              attribute: .centerX,
                                                              multiplier: 1,
                                                              constant: 0))
        vfl = "V:[self(\(ceil(height)))]"
        constraints = NSLayoutConstraint.constraints(withVisualFormat: vfl,
                                                     metrics: nil,
                                                     views: views)
        self.superview?.addConstraints(constraints)
        self.superview?.addConstraint(NSLayoutConstraint.init(item: self,
                                                              attribute: .centerY,
                                                              relatedBy: .equal,
                                                              toItem: self.superview,
                                                              attribute: .centerY,
                                                              multiplier: 1,
                                                              constant: 0))
    }
    
    func getLoadingViewSize(_ message: String? = nil) -> CGSize {
        
        return CGSize(width: MIN_LOADING_VIEW_WIDTH, height: MIN_LOADING_VIEW_WIDTH)
    }
}

extension UIActivityIndicatorView: LoadingSizeGetter {}
