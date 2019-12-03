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

fileprivate enum ActionType {
    case textTranslate
    case imgTranslate
    case idCardOcr
    case businessCardOcr
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
        translator.translate(image: UIImage.init(named: "translate_image1")!,
                             source: TLanguage.English,
                             target: TLanguage.Chinese) { (result, model) in
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
        }
    }
}
