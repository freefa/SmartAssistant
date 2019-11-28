//
//  HomeViewController.swift
//  SmartAssistant
//
//  Created by Louis.B on 2019/11/28.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import UIKit

class HomeViewController: SABaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Hello Smart Assistant"
        Log("Hello Smart Assistant")
    }
    @IBAction func goAiButtonTouched(_ sender: Any) {
        let _ = TencentAiSignature.signatureWith(params: ["app" : 123,
                                                          "hello" : "world",
                                                          "boy" : "hi",
                                                          "girl" : 500])
    }
}
