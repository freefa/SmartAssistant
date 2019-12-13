//
//  TranslateViewController.swift
//  SmartAssistant
//
//  Created by Louis.B on 2019/12/12.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import UIKit

protocol LanguageProvider: NSObjectProtocol {
    func sourceLanguageList() -> [TLanguage]
    func targetLanguageList() -> [TLanguage]
}

class TranslateViewController: SABaseViewController, LanguageProvider, SelectViewControllerDelegate {
    
    @IBOutlet weak var sourceButton: UIButton!
    
    @IBOutlet weak var targetButton: UIButton!
    
    @IBOutlet weak var sourceView: UIView!
    
    @IBOutlet weak var resultTextView: UITextView!
    
    public var sourceLanguage: TLanguage = .Chinese
    
    public var targetLanguage: TLanguage = .English
    
    var selectTarget = false
    
    let translator = TencentAiTranslator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupResultView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public func setupNavbar() {
        let commit = UIButton.init(type: .custom)
        commit.setTitle("翻译", for: .normal)
        commit.setTitleColor(.black, for: .normal)
        commit.addTarget(self, action: #selector(commitButtonTouched), for: .touchUpInside)
        let item = UIBarButtonItem.init(customView: commit)
        navigationItem.setRightBarButton(item, animated: false)
    }
    
    public func commitTranslate() {}
    
    private func setupResultView() {
        resultTextView.layer.cornerRadius = 5
        resultTextView.layer.borderWidth = 1
        resultTextView.layer.borderColor = UIColor.init(red: 242 / 255.0,
                                                        green: 242 / 255.0,
                                                        blue: 242 / 255.0,
                                                        alpha: 1).cgColor
        resultTextView.layer.masksToBounds = true
    }
    
    // MARK: LanguageProvider
    func sourceLanguageList() -> [TLanguage] {
        let languages = TEXT_TRANSLATE_SUPPORTED.keys.sorted { $0.rawValue < $1.rawValue }
        return languages
    }
    
    func targetLanguageList() -> [TLanguage] {
        let languages = TEXT_TRANSLATE_SUPPORTED[sourceLanguage]!.sorted { $0.rawValue < $1.rawValue }
        return languages
    }
    
    // MARK: actions
    @IBAction func sourceButtonTouched(_ sender: Any) {
        selectTarget = false
        let vc = SelectViewController<TLanguage, LanguageCell>()
        self.present(vc, animated: true, completion: nil)
        vc.dataSource = sourceLanguageList()
        vc.delegate = self
    }
    
    @IBAction func targetButtonTouched(_ sender: Any) {
        selectTarget = true
        let vc = SelectViewController<TLanguage, LanguageCell>()
        self.present(vc, animated: true, completion: nil)
        vc.dataSource = targetLanguageList()
        vc.delegate = self
    }
    
    @objc func commitButtonTouched() {
        commitTranslate()
    }
    
    func didSelectItem<Item>(_ item: Item) {
        if let language = item as? TLanguage {
            let display = LANGUAGE_DISPLAY_MAP[language]
            if selectTarget {
                targetButton.setTitle(display!, for: .normal)
                targetLanguage = language
            } else {
                sourceButton.setTitle(display!, for: .normal)
                sourceLanguage = language
            }
        }
    }
}
