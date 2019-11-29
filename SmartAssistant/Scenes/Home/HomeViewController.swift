//
//  HomeViewController.swift
//  SmartAssistant
//
//  Created by Louis.B on 2019/11/28.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import UIKit

class HomeViewController: SABaseViewController {
    
    var translator = TextTranslator()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Hello Smart Assistant"
        Log("Hello Smart Assistant")
    }
    
    @IBAction func goAiButtonTouched(_ sender: Any) {
//        let _ = TencentAiSignature.signatureWith(params: ["app" : 123,
//                                                          "hello" : " world-WI+DE",
//                                                          "boy" : "hi_Louis.B",
//                                                          "girl" : 500,
//                                                          "empty" : ""])
//        let image = UIImage(named: "idcard_front.jpg")!
//        IDCardOCR().idCardOcr(image: image, type: .front) { (success, idCard, result) in
//            Log("receive id card ocr callback")
//        }
//        TencentAiSignature.testSignature()
        translator.translate(text: "今天天气怎么样", source: "zh", target: "en") { (success, model) in
            Log("translate success: \(success)")
        }
    }
}
