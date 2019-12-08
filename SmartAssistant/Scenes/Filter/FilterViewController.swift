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
    case decoration
    case sticker
    case faceAge
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
        case .decoration:
            self.title = "选择变妆"
            self.sourceImageView.image = UIImage.init(named: "face_filter")
        case .sticker:
            self.title = "选择大头贴"
            self.sourceImageView.image = UIImage.init(named: "face_filter")
        case .faceAge:
            self.title = "颜龄检测"
            self.sourceImageView.image = UIImage.init(named: "face_filter")
        }
        self.selectButton.setTitle(self.title, for: .normal)
    }
    
    @IBAction func filterButtonTouched(_ sender: Any) {
        switch FilterViewController.filterType {
        case .faceAge:
            doFaceAge()
        default:
            let controller = FilterSelectController()
            controller.delegate = self
            controller.title = self.selectButton.title(for: .normal)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
    func doFaceFilter(filterNumber: Int) {
        LBToast.showLoading()
        let filter = FaceFilter.init(rawValue: filterNumber)
        self.imageEffector.faceFilter(image: self.sourceImageView.image!, filter: filter!) { (result, model) in
            DispatchQueue.main.async {
                if result.success {
                    self.filterImageView.image = model!.image
                } else {
                    Log("faceFilter failed: \(result.error!.description)")
                    LBToast.show("\(result.error!.description)")
                }
                LBToast.hideLoading()
            }
        }
    }
    
    func doSceneryFilter(filterNumber: Int) {
        LBToast.showLoading()
        self.imageEffector.sceneryFilter(image: self.sourceImageView.image!, filter: filterNumber) { (result, model) in
            DispatchQueue.main.async {
                if result.success {
                    self.filterImageView.image = model!.image
                } else {
                    Log("sceneryFilter failed: \(result.error!.description)")
                    LBToast.show("\(result.error!.description)")
                }
                LBToast.hideLoading()
            }
        }
    }
    
    func doFaceCosmetic(cosmeticNumber: Int) {
        LBToast.showLoading()
        let cosmetic = CosmeticType.init(rawValue: cosmeticNumber)
        self.imageEffector.faceCosmetic(image: self.sourceImageView.image!, cosmetic: cosmetic!) { (result, model) in
            DispatchQueue.main.async {
                if result.success {
                    self.filterImageView.image = model!.image
                } else {
                    Log("faceCosmetic failed: \(result.error!.description)")
                    LBToast.show("\(result.error!.description)")
                }
                LBToast.hideLoading()
            }
        }
    }
    
    func doFaceDecoration(decorationNumber: Int) {
        LBToast.showLoading()
        let decoration = DecorationType.init(rawValue: decorationNumber)
        self.imageEffector.faceDecoration(image: self.sourceImageView.image!, decoration: decoration!) { (result, model) in
            DispatchQueue.main.async {
                if result.success {
                    self.filterImageView.image = model!.image
                } else {
                    Log("faceDecoration failed: \(result.error!.description)")
                    LBToast.show("\(result.error!.description)")
                }
                LBToast.hideLoading()
            }
        }
    }
    
    func doFaceSticker(stickerNumber: Int) {
        LBToast.showLoading("")
        let sticker = StickerType.init(rawValue: stickerNumber)
        self.imageEffector.faceSticker(image: self.sourceImageView.image!, sticker: sticker!) { (result, model) in
            DispatchQueue.main.async {
                if result.success {
                    self.filterImageView.image = model!.image
                } else {
                    Log("faceSticker failed: \(result.error!.description)")
                    LBToast.show("\(result.error!.description)")
                }
                LBToast.hideLoading()
            }
        }
    }
    
    func doFaceAge() {
        LBToast.showLoading()
        self.imageEffector.detectFaceAge(image: self.sourceImageView.image!) { (result, model) in
            DispatchQueue.main.async {
                if result.success {
                    self.filterImageView.image = model!.image
                } else {
                    Log("detectFaceAge failed: \(result.error!.description)")
                    LBToast.show("\(result.error!.description)")
                }
                LBToast.hideLoading()
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
        case .decoration:
            doFaceDecoration(decorationNumber: index)
        case .sticker:
            doFaceSticker(stickerNumber: index)
        default:
            Log("do nothing")
        }
    }
}
