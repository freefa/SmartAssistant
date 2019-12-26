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
    
    var filterIndex = 1
    
    let imageEffector = TencentAiImageEffect()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitile()
        setupNavbar()
    }
    
    func setupTitile() {
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
    
    func setupNavbar() {
        let commit = UIButton.init(type: .custom)
        commit.setTitle("确定", for: .normal)
        commit.setTitleColor(.black, for: .normal)
        commit.addTarget(self, action: #selector(commitButtonTouched), for: .touchUpInside)
        let item = UIBarButtonItem.init(customView: commit)
        navigationItem.setRightBarButton(item, animated: false)
    }
    
    func updateFilterNameButton(name: String) {
        
    }
    
    @IBAction func addButton(_ sender: Any) {
        ImagePicker.pickImage { [weak self] (image) in
            self?.sourceImageView.image = image
        }
    }
    
    @objc func commitButtonTouched() {
        switch FilterViewController.filterType {
        case .face:
            doFaceFilter()
        case .scenery:
            doSceneryFilter()
        case .cosmetic:
            doFaceCosmetic()
        case .decoration:
            doFaceDecoration()
        case .sticker:
            doFaceSticker()
        default:
            Log("do nothing")
        }
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
    
    func doFaceFilter() {
        LBToast.showLoading()
        let filter = FaceFilter.init(rawValue: filterIndex)
        self.imageEffector.faceFilter(image: self.sourceImageView.image!, filter: filter!) { [weak self] (result, model) in
            DispatchQueue.main.async {
                if result.success {
                    self?.filterImageView.image = model!.image
                } else {
                    Log("faceFilter failed: \(result.error!.description)")
                    LBToast.show("\(result.error!.description)")
                }
                LBToast.hideLoading()
            }
        }
    }
    
    func doSceneryFilter() {
        LBToast.showLoading()
        self.imageEffector.sceneryFilter(image: self.sourceImageView.image!, filter: filterIndex) { [weak self] (result, model) in
            DispatchQueue.main.async {
                if result.success {
                    self?.filterImageView.image = model!.image
                } else {
                    Log("sceneryFilter failed: \(result.error!.description)")
                    LBToast.show("\(result.error!.description)")
                }
                LBToast.hideLoading()
            }
        }
    }
    
    func doFaceCosmetic() {
        LBToast.showLoading()
        let cosmetic = CosmeticType.init(rawValue: filterIndex)
        self.imageEffector.faceCosmetic(image: self.sourceImageView.image!, cosmetic: cosmetic!) { [weak self] (result, model) in
            DispatchQueue.main.async {
                if result.success {
                    self?.filterImageView.image = model!.image
                } else {
                    Log("faceCosmetic failed: \(result.error!.description)")
                    LBToast.show("\(result.error!.description)")
                }
                LBToast.hideLoading()
            }
        }
    }
    
    func doFaceDecoration() {
        LBToast.showLoading()
        let decoration = DecorationType.init(rawValue: filterIndex)
        self.imageEffector.faceDecoration(image: self.sourceImageView.image!, decoration: decoration!) { [weak self] (result, model) in
            DispatchQueue.main.async {
                if result.success {
                    self?.filterImageView.image = model!.image
                } else {
                    Log("faceDecoration failed: \(result.error!.description)")
                    LBToast.show("\(result.error!.description)")
                }
                LBToast.hideLoading()
            }
        }
    }
    
    func doFaceSticker() {
        LBToast.showLoading("")
        let sticker = StickerType.init(rawValue: filterIndex)
        self.imageEffector.faceSticker(image: self.sourceImageView.image!, sticker: sticker!) { [weak self] (result, model) in
            DispatchQueue.main.async {
                if result.success {
                    self?.filterImageView.image = model!.image
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
        self.imageEffector.detectFaceAge(image: self.sourceImageView.image!) { [weak self] (result, model) in
            DispatchQueue.main.async {
                if result.success {
                    self?.filterImageView.image = model!.image
                } else {
                    Log("detectFaceAge failed: \(result.error!.description)")
                    LBToast.show("\(result.error!.description)")
                }
                LBToast.hideLoading()
            }
        }
    }
    
    // MARK:FilterSelectDelegate
    func didSelectFilter(info: (index: Int, name: String)) {
        filterIndex = info.index
        self.selectButton.setTitle(info.name, for: .normal)
    }
}
