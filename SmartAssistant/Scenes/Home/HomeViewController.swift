//
//  HomeViewController.swift
//  SmartAssistant
//
//  Created by Louis.B on 2019/11/28.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import UIKit
@_exported import LBToast

fileprivate let ROW_NAME_KEY = "name"
fileprivate let ROW_TYPE_KEY = "type"

enum ActionType {
    case textTranslate
    case imgTranslate
    case generalOcr
    case idCardOcr
    case businessCardOcr
    case carLisenceOcr
    case driverLisenceOcr
    case numberPlateOcr
    case bankCardOcr
    case businessLicenseOcr
    case handWritingOcr
    case imageTest
    case faceFilter
    case sceneryFilter
    case cosmetic
    case decoration
    case sticker
    case faceAge
    case toast
}

class HomeViewController: SABaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var translator = TencentAiTranslator()
    var ocr = TencentAiOCR()
    var dataSouce = [[String : Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "实用工具"
        Log("Hello Smart Assistant")
        tableView.tableFooterView = UIView(frame: .zero)
        configDataSouce()
    }
    
    func configDataSouce() {
        dataSouce.append([ROW_NAME_KEY : "文本翻译", ROW_TYPE_KEY : ActionType.textTranslate])
        dataSouce.append([ROW_NAME_KEY : "图片翻译", ROW_TYPE_KEY : ActionType.imgTranslate])
        dataSouce.append([ROW_NAME_KEY : "身份证识别", ROW_TYPE_KEY : ActionType.idCardOcr])
        dataSouce.append([ROW_NAME_KEY : "名片识别", ROW_TYPE_KEY : ActionType.businessCardOcr])
        dataSouce.append([ROW_NAME_KEY : "行驶证识别", ROW_TYPE_KEY : ActionType.carLisenceOcr])
        dataSouce.append([ROW_NAME_KEY : "驾驶证识别", ROW_TYPE_KEY : ActionType.driverLisenceOcr])
        dataSouce.append([ROW_NAME_KEY : "车牌号识别", ROW_TYPE_KEY : ActionType.numberPlateOcr])
        dataSouce.append([ROW_NAME_KEY : "银行卡识别", ROW_TYPE_KEY : ActionType.bankCardOcr])
        dataSouce.append([ROW_NAME_KEY : "营业执照识别", ROW_TYPE_KEY : ActionType.businessLicenseOcr])
        dataSouce.append([ROW_NAME_KEY : "手写体文字识别", ROW_TYPE_KEY : ActionType.handWritingOcr])
        dataSouce.append([ROW_NAME_KEY : "通用文字识别", ROW_TYPE_KEY : ActionType.generalOcr])
        dataSouce.append([ROW_NAME_KEY : "人脸滤镜", ROW_TYPE_KEY : ActionType.faceFilter])
        dataSouce.append([ROW_NAME_KEY : "风景滤镜", ROW_TYPE_KEY : ActionType.sceneryFilter])
        dataSouce.append([ROW_NAME_KEY : "人脸美妆", ROW_TYPE_KEY : ActionType.cosmetic])
        dataSouce.append([ROW_NAME_KEY : "人脸变妆", ROW_TYPE_KEY : ActionType.decoration])
        dataSouce.append([ROW_NAME_KEY : "大头贴", ROW_TYPE_KEY : ActionType.sticker])
        dataSouce.append([ROW_NAME_KEY : "颜龄检测", ROW_TYPE_KEY : ActionType.faceAge])
        dataSouce.append([ROW_NAME_KEY : "Toast测试", ROW_TYPE_KEY : ActionType.toast])
        dataSouce.append([ROW_NAME_KEY : "图片压缩测试", ROW_TYPE_KEY : ActionType.imageTest])
    }
    
    // MARK: action method
    func translateText() {
        let vc = TextTranslateViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func translateImage() {
        let vc = ImageTranslateViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func ocr(type: OCRType) {
        let vc = OCRViewController()
        vc.OcrType = type
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: UITableViewDelegate & dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSouce.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "homeCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
        }
        cell?.textLabel?.text = (dataSouce[indexPath.row][ROW_NAME_KEY] as! String)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let action = dataSouce[indexPath.row][ROW_TYPE_KEY] as! ActionType
        var controller: SABaseViewController?
        switch action {
        case .textTranslate:
            translateText()
        case .imgTranslate:
            translateImage()
        case .idCardOcr:
            ocr(type: .idcard)
        case .businessCardOcr:
            ocr(type: .businessCard)
        case .carLisenceOcr:
            ocr(type: .carLisence)
        case .driverLisenceOcr:
            ocr(type: .driverLisence)
        case .numberPlateOcr:
            ocr(type: .numberPlate)
        case .bankCardOcr:
            ocr(type: .bankCard)
        case .businessLicenseOcr:
            ocr(type: .businessLisence)
        case .handWritingOcr:
            ocr(type: .handWriting)
        case .generalOcr:
            ocr(type: .general)
        case .imageTest:
            controller = ImageTestViewController()
        case .faceFilter:
            controller = FilterViewController()
            FilterViewController.filterType = .face
        case .sceneryFilter:
            controller = FilterViewController()
            FilterViewController.filterType = .scenery
        case .cosmetic:
            controller = FilterViewController()
            FilterViewController.filterType = .cosmetic
        case .decoration:
            controller = FilterViewController()
            FilterViewController.filterType = .decoration
        case .sticker:
            controller = FilterViewController()
            FilterViewController.filterType = .sticker
        case .faceAge:
            controller = FilterViewController()
            FilterViewController.filterType = .faceAge
        case .toast:
            LBToast.show("网络异常,请稍后重试")
        }
        if let vc = controller {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
