//
//  FaceViewController.swift
//  SmartAssistant
//
//  Created by Louis.B on 2019/12/5.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import UIKit
@_exported import TencentAiImage

class FaceViewController: SABaseViewController, FaceFilterSelectDelegate {

    @IBOutlet weak var sourceImageView: UIImageView!
    
    @IBOutlet weak var filterImageView: UIImageView!
    
    let faceFilter = TencentAiImageEffect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sourceImageView.image = UIImage.init(named: "face_filter")
    }
    
    @IBAction func filterButtonTouched(_ sender: Any) {
        let selector = FaceFilterSelectController()
        selector.delegate = self
        self.navigationController?.pushViewController(selector, animated: true)
    }
    
    // MARK: FaceFilterSelectDelegate
    func didSelectFilter(filter: FaceFilter) {
        Log("did select filter: \(filter), value: \(filter.rawValue)")
        faceFilter.faceFilter(image: self.sourceImageView.image!, filter: filter) { (result, model) in
            DispatchQueue.main.async {
                if result.success {
                    self.filterImageView.image = model!.image
                } else {
                    Log("Int.min: \(Int16.min)")
                    Log("faceFilter failed: \(result.error!.description)")
                }
            }
        }
    }
}
