//
//  ImageTestViewController.swift
//  SmartAssistant
//
//  Created by Louis.B on 2019/12/4.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import UIKit

class ImageTestViewController: SABaseViewController {
    @IBOutlet weak var sourceImageView: UIImageView!
    @IBOutlet weak var compressImageView: UIImageView!
    
    var sourceImage = UIImage.init(named: "driver_lisence")!
    var imageToCompress = UIImage.init(named: "driver_lisence")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sourceImageView.image = sourceImage
//        self.compressImageView.image = imageToCompress
    }
    
    @IBAction func compressButtonTouched(_ sender: Any) {
        let img = imageToCompress.compressForBase64Encoding()
        self.compressImageView.image = img
    }
}
