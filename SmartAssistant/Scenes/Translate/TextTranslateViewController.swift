//
//  TextTranslateViewController.swift
//  SmartAssistant
//
//  Created by Louis.B on 2019/12/12.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import UIKit

class TextTranslateViewController: TranslateViewController, UITextViewDelegate {

    var sourceTextView: UITextView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "TranslateViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSourceTextView()
    }
    
    private func setupSourceTextView() {
        sourceTextView = UITextView()
        sourceTextView.translatesAutoresizingMaskIntoConstraints = false
        sourceTextView.font = UIFont.systemFont(ofSize: 18)
        sourceTextView.layer.cornerRadius = 5
        sourceTextView.layer.masksToBounds = true
        sourceTextView.layer.borderColor = UIColor.init(red: 182 / 255.0,
                                                        green: 182 / 255.0,
                                                        blue: 182 / 255.0,
                                                        alpha: 1.0).cgColor
        sourceTextView.layer.borderWidth = 1.0
        sourceTextView.returnKeyType = .done
        sourceTextView.delegate = self
        self.sourceView.addSubview(sourceTextView)
        
        let views = ["sourceTextView" : sourceTextView as Any]
        var vfl = "H:|-0-[sourceTextView]-0-|"
        sourceView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: vfl,
                                                                 metrics: nil,
                                                                 views: views))
        vfl = "V:|-0-[sourceTextView]-0-|"
        sourceView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: vfl,
                                                                 metrics: nil,
                                                                 views: views))
    }
    
    override func commitTranslate() {
        sourceTextView.resignFirstResponder()
        
        guard !sourceTextView.text.isEmpty else {
            LBToast.show("请输入需要翻译的文字")
            return
        }
        
        LBToast.showLoading("正在加载...")
        translator.translate(text: sourceTextView.text!,
                             source: sourceLanguage,
                             target: targetLanguage) { [weak self] (result, model) in
                                DispatchQueue.main.async {
                                    Log("text translate success: \(result.success)")
                                    if !result.success {
                                        LBToast.show("\(result.error!.description)")
                                    } else {
                                        self?.resultTextView.text = model?.target
                                    }
                                    LBToast.hideLoading()
                                }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if !textView.text.isEmpty {
            Log("begin translate request: \(textView.text!)")
        }
    }
    
}
