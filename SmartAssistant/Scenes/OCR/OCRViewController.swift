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

class OCRViewController: SABaseViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
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
        ocr.businessCardOCR(image: self.sourceImageView.image!) { (result, businessCard) in
            DispatchQueue.main.async {
                Log("businessCardOCR success: \(result.success)")
                if !result.success {
                    LBToast.show("\(result.error!.description)")
                }
            }
        }
    }
    
    func driverLisenceOcr(type: DriverLicenseType) {
        ocr.driverLisenceOCR(image: self.sourceImageView.image!, type: type) { (result, driverLisence) in
            DispatchQueue.main.async {
                Log("driverLisenceOCR success: \(result.success)")
                if !result.success {
                    Log(result.error!.description)
                    LBToast.show("\(result.error!.description)")
                }
            }
        }
    }
    
    func numberPlateOcr() {
        ocr.numberPlateOCR(image: self.sourceImageView.image!) { (result, numberPlate) in
            DispatchQueue.main.async {
                Log("numberPlateOCR success: \(result.success)")
                if !result.success {
                    Log(result.error!.description)
                    LBToast.show("\(result.error!.description)")
                    LBToast.show("\(result.error!.description)")
                }
            }
        }
    }
    
    func bankCardOcr() {
        ocr.bankCardOCR(image: self.sourceImageView.image!) { (result, bankCard) in
            DispatchQueue.main.async {
                Log("bankCardOCR success: \(result.success)")
                if !result.success {
                    Log(result.error!.description)
                    LBToast.show("\(result.error!.description)")
                }
            }
        }
    }
    
    func businessLicenseOcr() {
        ocr.businessLicenseOCR(image: self.sourceImageView.image!) { (result, businessLicense) in
            DispatchQueue.main.async {
                Log("businessLicenseOCR success: \(result.success)")
                if !result.success {
                    Log(result.error!.description)
                    LBToast.show("\(result.error!.description)")
                }
            }
        }
    }
    
    func handWritingOcr() {
        ocr.handWritingOCR(image: self.sourceImageView.image!) { (result, handWriting) in
            DispatchQueue.main.async {
                Log("handWritingOCR success: \(result.success)")
                if !result.success {
                    Log(result.error!.description)
                    LBToast.show("\(result.error!.description)")
                }
            }
        }
    }
    
    func generalOcr() {
        ocr.generalOCR(image: self.sourceImageView.image!) { (result, GeneralOCR) in
            DispatchQueue.main.async {
                Log("generalOCR success: \(result.success)")
                if !result.success {
                    Log(result.error!.description)
                    LBToast.show("\(result.error!.description)")
                }
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
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            Log("originalImage nil")
            return
        }
        sourceImageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
