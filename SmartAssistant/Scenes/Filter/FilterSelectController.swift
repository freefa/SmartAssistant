//
//  FilterSelectController.swift
//  SmartAssistant
//
//  Created by Louis.B on 2019/12/5.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import UIKit

protocol FilterSelectDelegate: NSObjectProtocol {
    func didSelectFilter(info: (index: Int, name: String))
}

class FilterSelectController: SABaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [[Int : String]]()
    
    weak var delegate: FilterSelectDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDataSource()
    }
    
    func initDataSource() {
        switch FilterViewController.filterType {
        case .face:
            for info in FACE_FILTERS {
                dataSource.append([info.keys.first!.rawValue : info.values.first!])
            }
        case .scenery:
            for i in SCENERY_FILTER_CODE {
                let title = String(format: "效果%ld", i)
                dataSource.append([i : title])
            }
        case .cosmetic:
            for info in FACE_COSMETICS {
                dataSource.append([info.keys.first!.rawValue : info.values.first!])
            }
        case .decoration:
            for info in FACE_DECORATIONS {
                dataSource.append([info.keys.first!.rawValue : info.values.first!])
            }
        case .sticker:
            for info in FACE_STICKERS {
                dataSource.append([info.keys.first!.rawValue : info.values.first!])
            }
        default:
            Log("")
        }
    }

    // MARK: UITableViewDelegate & dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "faceFilterSelectCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
        }
        let info = dataSource[indexPath.row]
        cell?.textLabel?.text = info.values.first
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let callback = self.delegate {
            let info = dataSource[indexPath.row]
            callback.didSelectFilter(info: (info.keys.first!, info.values.first!))
        }
        self.navigationController?.popViewController(animated: true)
    }
}
