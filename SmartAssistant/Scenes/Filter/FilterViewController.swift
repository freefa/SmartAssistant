//
//  FilterViewController.swift
//  SmartAssistant
//
//  Created by Louis.B on 2019/12/5.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import UIKit
@_exported import TencentAiImage

enum FilterType {
    case face
    case scenery
}

class FilterViewController: SABaseViewController, FilterSelectDelegate {
    
    @IBOutlet weak var sourceImageView: UIImageView!
    
    @IBOutlet weak var filterImageView: UIImageView!
    
    static var filterType: FilterType = .face
    
    let filter = TencentAiImageEffect()

    override func viewDidLoad() {
        super.viewDidLoad()
        switch FilterViewController.filterType {
        case .face:
            self.sourceImageView.image = UIImage.init(named: "face_filter")
        case .scenery:
            self.sourceImageView.image = UIImage.init(named: "scenery_filter")
        }
    }
    
    @IBAction func filterButtonTouched(_ sender: Any) {
        let controller = FilterSelectController()
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func doFaceFilter(filterNumber: Int) {
        let filter = FaceFilter.init(rawValue: filterNumber)
        self.filter.faceFilter(image: self.sourceImageView.image!, filter: filter!) { (result, model) in
            DispatchQueue.main.async {
                if result.success {
                    self.filterImageView.image = model!.image
                } else {
                    Log("faceFilter failed: \(result.error!.description)")
                }
            }
        }
    }
    
    func doSceneryFilter(filterNumber: Int) {
        self.filter.sceneryFilter(image: self.sourceImageView.image!, filter: filterNumber) { (result, model) in
            DispatchQueue.main.async {
                if result.success {
                    self.filterImageView.image = model!.image
                } else {
                    Log("sceneryFilter failed: \(result.error!.description)")
                }                
            }
        }
    }
    
    // MARK:FilterSelectDelegate
    func didSelectFilterAtIndex(index: Int) {
        switch FilterViewController.filterType {
        case .face:
            doFaceFilter(filterNumber: index)
        case .scenery:
            doSceneryFilter(filterNumber: index)
        }
    }
}
