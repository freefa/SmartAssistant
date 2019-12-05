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
    case cosmetic
}

class FilterViewController: SABaseViewController, FilterSelectDelegate {
    
    @IBOutlet weak var sourceImageView: UIImageView!
    
    @IBOutlet weak var filterImageView: UIImageView!
    
    @IBOutlet weak var selectButton: UIButton!
    
    static var filterType: FilterType = .face
    
    let imageEffector = TencentAiImageEffect()

    override func viewDidLoad() {
        super.viewDidLoad()
        switch FilterViewController.filterType {
        case .face:
            self.title = "选择滤镜"
            self.sourceImageView.image = UIImage.init(named: "face_filter")
        case .scenery:
            self.title = "选择效果"
            self.sourceImageView.image = UIImage.init(named: "scenery_filter")
        case .cosmetic:
            self.title = "选择美妆"
            self.sourceImageView.image = UIImage.init(named: "face_filter")
        }
        self.selectButton.setTitle(self.title, for: .normal)
    }
    
    @IBAction func filterButtonTouched(_ sender: Any) {
        let controller = FilterSelectController()
        controller.delegate = self
        controller.title = self.selectButton.title(for: .normal)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func doFaceFilter(filterNumber: Int) {
        let filter = FaceFilter.init(rawValue: filterNumber)
        self.imageEffector.faceFilter(image: self.sourceImageView.image!, filter: filter!) { (result, model) in
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
        self.imageEffector.sceneryFilter(image: self.sourceImageView.image!, filter: filterNumber) { (result, model) in
            DispatchQueue.main.async {
                if result.success {
                    self.filterImageView.image = model!.image
                } else {
                    Log("sceneryFilter failed: \(result.error!.description)")
                }
            }
        }
    }
    
    func doFaceCosmetic(cosmeticNumber: Int) {
        let cosmetic = CosmeticType.init(rawValue: cosmeticNumber)
        self.imageEffector.faceCosmetic(image: self.sourceImageView.image!, cosmetic: cosmetic!) { (result, model) in
            DispatchQueue.main.async {
                if result.success {
                    self.filterImageView.image = model!.image
                } else {
                    Log("faceCosmetic failed: \(result.error!.description)")
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
        case .cosmetic:
            doFaceCosmetic(cosmeticNumber: index)
        }
    }
}
