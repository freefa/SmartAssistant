//
//  FaceFilterSelectController.swift
//  SmartAssistant
//
//  Created by Louis.B on 2019/12/5.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import UIKit

protocol FaceFilterSelectDelegate: NSObjectProtocol {
    func didSelectFilter(filter: FaceFilter)
}

class FaceFilterSelectController: SABaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: FaceFilterSelectDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择效果"
    }
    
    // MARK: UITableViewDelegate & dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FaceFilters.count
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
        let info = FaceFilters[indexPath.row]
        let filter = FaceFilter.init(rawValue: indexPath.row + 1)
        cell?.textLabel?.text = info[filter!]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let filter = FaceFilter.init(rawValue: indexPath.row + 1)!
        if let callback = self.delegate {
            callback.didSelectFilter(filter: filter)
        }
        self.navigationController?.popViewController(animated: true)
    }

}
