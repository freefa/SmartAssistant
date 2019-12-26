//
//  OCRViewController.swift
//  SmartAssistant
//
//  Created by Louis.B on 2019/12/14.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import UIKit

enum OCRType {
    case idcard
    case businessCard
    case carLisence
    case driverLisence
    case numberPlate
    case bankCard
    case businessLisence
    case handWriting
    case general
}

class OCRViewController: SABaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var sourceImageView: UIImageView!
    
    @IBOutlet weak var idcardSwitchButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var OcrType = OCRType.idcard
    
    var idcardType = IDCardType.front
    
    private var idcardFront: IDCard?
    
    private var idcardBack: IDCard?
    
    private var ocrResult: GeneralOCR?
    
    private let ocr = TencentAiOCR()
    
    private var dataSource = [[String : String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupSubviews()
    }
    
    func setupNavBar() {
        let commit = UIButton.init(type: .custom)
        commit.setTitle("识别", for: .normal)
        commit.setTitleColor(.black, for: .normal)
        commit.addTarget(self, action: #selector(recognizeButtonTouched(button:)), for: .touchUpInside)
        let item = UIBarButtonItem.init(customView: commit)
        navigationItem.setRightBarButton(item, animated: false)
    }
    
    func setupSubviews() {
        sourceImageView.layer.masksToBounds = true
        sourceImageView.layer.cornerRadius = 5
        sourceImageView.layer.borderWidth = 1
        sourceImageView.layer.borderColor = UIColor.init(red: 222 / 255.0,
                                                         green: 222 / 255.0,
                                                         blue: 222 / 255.0,
                                                         alpha: 1).cgColor
        idcardSwitchButton.isHidden = OcrType != .idcard
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func addButtonTouched(_ sender: Any) {
        ImagePicker.pickImage { (image) in
            self.sourceImageView.image = image
        }
    }
    
    @objc func recognizeButtonTouched(button: Any) {
        guard let _ = sourceImageView.image else {
            LBToast.show("请选择图片")
            return
        }
        switch OcrType {
        case .idcard:
            idCardOCR()
        case .businessCard:
            businessCardOcr()
        case .carLisence:
            driverLisenceOcr(type: .carLisence)
        case .driverLisence:
            driverLisenceOcr(type: .driverLisence)
        case .numberPlate:
            numberPlateOcr()
        case .bankCard:
            bankCardOcr()
        case .businessLisence:
            businessLicenseOcr()
        case .handWriting:
            handWritingOcr()
        default:
            generalOcr()
        }
    }
    
    @IBAction func idcardSwitchButtonTouched(_ sender: Any) {
        if idcardType == .front {
            idcardType = .back
            self.idcardSwitchButton.setTitle("反面", for: .normal)
        } else {
            idcardType = .front
            self.idcardSwitchButton.setTitle("正面", for: .normal)
        }
    }
    
    func updateDataSourceByIdcardFront(front: IDCard) {
        dataSource.removeAll()
        dataSource.append(["姓名" : front.name!])
        dataSource.append(["性别" : front.gender!])
        dataSource.append(["民族" : front.nation!])
        dataSource.append(["出生" : front.birthday!])
        dataSource.append(["住址" : front.address!])
        dataSource.append(["公民身份证号" : front.id!])
        if let back = idcardBack {
            dataSource.append(["有效期" : back.validDate!])
            dataSource.append(["签发机关" : back.authority!])
        }
    }
    
    func updateDataSourceByIdcardBack(back: IDCard) {
        dataSource.removeAll()
        if let front = idcardFront {
            dataSource.append(["姓名" : front.name!])
            dataSource.append(["性别" : front.gender!])
            dataSource.append(["民族" : front.nation!])
            dataSource.append(["出生" : front.birthday!])
            dataSource.append(["住址" : front.address!])
            dataSource.append(["公民身份证号" : front.id!])
        }
        dataSource.append(["有效期" : back.validDate!])
        dataSource.append(["签发机关" : back.authority!])
    }
    
    func updateDataSource(ocrResult: GeneralOCR) {
        guard let items = ocrResult.itemList else {
            return
        }
        dataSource.removeAll()
        for item in items {
            dataSource.append([item.name ?? "" : item.value ?? ""])
        }
    }
    
    // MARK: actions
    func idCardOCR() {
        LBToast.showLoading()
        ocr.IDCardOCR(image: self.sourceImageView.image!, type: idcardType) { [weak self] (result, idCard) in
            DispatchQueue.main.async {
                LBToast.hideLoading()
                guard result.success else {
                    LBToast.show(result.error?.description)
                    return
                }
                if self?.idcardType == .front {
                    self?.idcardFront = idCard
                    self?.updateDataSourceByIdcardFront(front: idCard!)
                } else {
                    self?.idcardBack = idCard
                    self?.updateDataSourceByIdcardBack(back: idCard!)
                }
                self?.tableView.reloadData()
            }
        }
    }
    
    func businessCardOcr() {
        LBToast.showLoading()
        ocr.businessCardOCR(image: self.sourceImageView.image!) { [weak self] (result, businessCard) in
            DispatchQueue.main.async {
                LBToast.hideLoading()
                Log("businessCardOCR success: \(result.success)")
                guard result.success else {
                    LBToast.show("\(result.error!.description)")
                    return
                }
                self?.updateDataSource(ocrResult: businessCard!)
                self?.tableView.reloadData()
            }
        }
    }
    
    func driverLisenceOcr(type: DriverLicenseType) {
        LBToast.showLoading()
        ocr.driverLisenceOCR(image: self.sourceImageView.image!, type: type) { [weak self] (result, driverLisence) in
            DispatchQueue.main.async {
                LBToast.hideLoading()
                Log("driverLisenceOCR success: \(result.success)")
                guard result.success else {
                    LBToast.show("\(result.error!.description)")
                    return
                }
                self?.updateDataSource(ocrResult: driverLisence!)
                self?.tableView.reloadData()
            }
        }
    }
    
    func numberPlateOcr() {
        LBToast.showLoading()
        ocr.numberPlateOCR(image: self.sourceImageView.image!) { [weak self] (result, numberPlate) in
            DispatchQueue.main.async {
                LBToast.hideLoading()
                Log("numberPlateOCR success: \(result.success)")
                guard result.success else {
                    LBToast.show("\(result.error!.description)")
                    return
                }
                self?.updateDataSource(ocrResult: numberPlate!)
                self?.tableView.reloadData()
            }
        }
    }
    
    func bankCardOcr() {
        LBToast.showLoading()
        ocr.bankCardOCR(image: self.sourceImageView.image!) { [weak self] (result, bankCard) in
            DispatchQueue.main.async {
                LBToast.hideLoading()
                Log("bankCardOCR success: \(result.success)")
                guard result.success else {
                    LBToast.show("\(result.error!.description)")
                    return
                }
                self?.updateDataSource(ocrResult: bankCard!)
                self?.tableView.reloadData()
            }
        }
    }
    
    func businessLicenseOcr() {
        LBToast.showLoading()
        ocr.businessLicenseOCR(image: self.sourceImageView.image!) { [weak self] (result, businessLicense) in
            DispatchQueue.main.async {
                LBToast.hideLoading()
                Log("businessLicenseOCR success: \(result.success)")
                guard result.success else {
                    LBToast.show("\(result.error!.description)")
                    return
                }
                self?.updateDataSource(ocrResult: businessLicense!)
                self?.tableView.reloadData()
            }
        }
    }
    
    func handWritingOcr() {
        LBToast.hideLoading()
        ocr.handWritingOCR(image: self.sourceImageView.image!) { [weak self] (result, handWriting) in
            DispatchQueue.main.async {
                LBToast.hideLoading()
                Log("handWritingOCR success: \(result.success)")
                guard result.success else {
                    LBToast.show("\(result.error!.description)")
                    return
                }
                self?.updateDataSource(ocrResult: handWriting!)
                self?.tableView.reloadData()
            }
        }
    }
    
    func generalOcr() {
        LBToast.hideLoading()
        ocr.generalOCR(image: self.sourceImageView.image!) { [weak self] (result, generalOCR) in
            DispatchQueue.main.async {
                LBToast.hideLoading()
                Log("generalOCR success: \(result.success)")
                guard result.success else {
                    LBToast.show("\(result.error!.description)")
                    return
                }
                self?.updateDataSource(ocrResult: generalOCR!)
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: UITableViewDataSource & delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ocrCellId = "ocrCellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: ocrCellId)
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: ocrCellId)
        }
        cell?.textLabel?.text = dataSource[indexPath.row].keys.first!
        cell?.detailTextLabel?.text = dataSource[indexPath.row].values.first!
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
