//
//  ImageTranslateViewController.swift
//  SmartAssistant
//
//  Created by Louis.B on 2019/12/12.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import UIKit

class ImageTranslateViewController: TranslateViewController {
    
    var sourceImageView: UIImageView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "TranslateViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    func setupSubviews() {
        addSourceImageView()
        initAddImageButton()
    }
    
    func addSourceImageView() {
        sourceImageView = UIImageView()
        sourceImageView.translatesAutoresizingMaskIntoConstraints = false
        sourceImageView.contentMode = .scaleAspectFit
        self.sourceView.addSubview(sourceImageView)
        let views = ["sourceImageView" : sourceImageView as Any]
        var vfl = "H:|-0-[sourceImageView]-0-|"
        sourceView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: vfl,
                                                                 metrics: nil,
                                                                 views: views))
        vfl = "V:|-0-[sourceImageView]-0-|"
        sourceView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: vfl,
                                                                 metrics: nil,
                                                                 views: views))
    }
    
    func initAddImageButton() {
        let button = UIButton.init(type: .custom)
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitle("+", for: .normal)
        button.addTarget(self, action: #selector(selectImageButtonTouched), for: .touchUpInside)
        sourceView.addSubview(button)
        let views = ["button" : button as Any]
        var vfl = "H:[button(40)]-10-|"
        sourceView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: vfl,
                                                                 metrics: nil,
                                                                 views: views))
        vfl = "V:[button(40)]-10-|"
        sourceView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: vfl,
                                                                 metrics: nil,
                                                                 views: views))
    }
    
    override func sourceLanguageList() -> [TLanguage] {
        return IMG_TRANSLATE_SUPPORTED.keys.sorted { $0.rawValue < $1.rawValue }
    }
    
    override func targetLanguageList() -> [TLanguage] {
        return (IMG_TRANSLATE_SUPPORTED[sourceLanguage]?.sorted { $0.rawValue < $1.rawValue })!
    }
    
    @objc func selectImageButtonTouched() {
        ImagePicker.pickImage { (image) in
            self.sourceImageView.image = image
        }
    }
    
    override func commitTranslate() {
        guard let image = sourceImageView.image else {
            LBToast.show("请选择图片")
            return
        }
        LBToast.showLoading()
        translator.translate(image: image,
                             source: sourceLanguage,
                             target: targetLanguage) { [weak self] (result, model) in
                                DispatchQueue.main.async {
                                    LBToast.hideLoading()
                                    Log("translate success: \(result.success)")
                                    if !result.success {
                                        LBToast.show("\(result.error!.description)")
                                    } else {
                                        self?.handleResults(result: model!)
                                    }
                                }
        }
    }
    
    func handleResults(result: ImageTranslateResult) {
        var text = ""
        result.results?.forEach({ (item) in
            text.append(item.target!)
        })
        resultTextView.text = text
    }
}
