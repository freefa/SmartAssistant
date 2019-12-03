//
//  HomeViewController.swift
//  SmartAssistant
//
//  Created by Louis.B on 2019/11/28.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import UIKit

class HomeViewController: SABaseViewController {
    
    var translator = TTranslator()
    var ocr = IDCardOCR()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Hello Smart Assistant"
        Log("Hello Smart Assistant")
    }
    
    @IBAction func goAiButtonTouched(_ sender: Any) {
//        translateText()
        translateImage()
//        testIdCardOCR()
    }
    
    func translateText() {
        translator.translate(text: "今天天气怎么样", source: TLanguage.Chinese, target: TLanguage.English) { (success, model) in
            Log("translate success: \(success)")
        }
    }
    
    func translateImage() {
        translator.translate(image: UIImage.init(named: "translate_image1")!,
                             source: TLanguage.English,
                             target: TLanguage.Chinese) { (success, model) in
            Log("translate success: \(success)")
        }
    }
    
    func testIdCardOCR() {
        ocr.idCardOcr(image: UIImage.init(named: "idcard_back")!, type: .back) { (success, idCardOcr) in
            Log("idCardOcr success: \(success)")
        }
    }
}
