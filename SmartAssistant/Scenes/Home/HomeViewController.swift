//
//  HomeViewController.swift
//  SmartAssistant
//
//  Created by Louis.B on 2019/11/28.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import UIKit

fileprivate let ROW_NAME_KEY = "name"
fileprivate let ROW_TYPE_KEY = "type"

enum ActionType {
    case textTranslate
    case imgTranslate
    case idCardOcr
    case businessCardOcr
    case carLisenceOcr
    case driverLisenceOcr
    case numberPlateOcr
    case bankCardOcr
    case businessLicenseOcr
    case imageTest
}

class HomeViewController: SABaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var translator = TencentAiTranslator()
    var ocr = TencentAiOCR()
    var dataSouce = [[String : Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Hello Smart Assistant"
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
        dataSouce.append([ROW_NAME_KEY : "图片压缩测试", ROW_TYPE_KEY : ActionType.imageTest])
    }
    
    // MARK: action method
    func translateText() {
        translator.translate(text: "今天天气怎么样",
                             source: TLanguage.Chinese,
                             target: TLanguage.English) { (result, model) in
            Log("text translate success: \(result.success)")
        }
    }
    
    func translateImage() {
        translator.translate(image: UIImage.init(named: "translate_image")!,
                             source: TLanguage.Chinese,
                             target: TLanguage.English) { (result, model) in
                                Log("translate success: \(result.success)")
        }
    }
    
    func testIdCardOCR() {
        ocr.IDCardOCR(image: UIImage.init(named: "idcard_front")!, type: .front) { (result, idCard) in
            Log("IDCardOCR success: \(result.success)")
        }
    }
    
    func businessCardOcr() {
        ocr.businessCardOCR(image: UIImage.init(named: "bc_card")!) { (result, businessCard) in
            Log("businessCardOCR success: \(result.success)")
        }
    }
    
    func driverLisenceOcr(type: DriverLisenceType) {
        let imgName = type == .carLisence ? "car_lisence" : "driver_lisence"
        ocr.driverLisenceOCR(image: UIImage.init(named: imgName)!, type: type) { (result, driverLisence) in
            Log("driverLisenceOCR success: \(result.success)")
            if !result.success {
                Log(result.error!.description)
            }
        }
    }
    
    func numberPlateOcr() {
        ocr.numberPlateOCR(image: UIImage.init(named: "number_plate")!) { (result, numberPlate) in
            Log("numberPlateOCR success: \(result.success)")
            if !result.success {
                Log(result.error!.description)
            }
        }
    }
    
    func bankCardOcr() {
        ocr.bankCardOCR(image: UIImage.init(named: "bank_card")!) { (result, bankCard) in
            Log("bankCardOCR success: \(result.success)")
            if !result.success {
                Log(result.error!.description)
            }
        }
    }
    
    func businessLicenseOcr() {
        ocr.businessLicenseOCR(image: UIImage.init(named: "business_license")!) { (result, businessLicense) in
            Log("businessLicenseOCR success: \(result.success)")
            if !result.success {
                Log(result.error!.description)
            }
        }
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
        switch action {
        case .textTranslate:
            translateText()
        case .imgTranslate:
            translateImage()
        case .idCardOcr:
            testIdCardOCR()
        case .businessCardOcr:
            businessCardOcr()
        case .carLisenceOcr:
            driverLisenceOcr(type: .carLisence)
        case .driverLisenceOcr:
            driverLisenceOcr(type: .driverLisence)
        case .numberPlateOcr:
            numberPlateOcr()
        case .bankCardOcr:
            bankCardOcr()
        case .businessLicenseOcr:
            businessLicenseOcr()
        case .imageTest:
            let controller = ImageTestViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
