//
//  SelectViewController.swift
//  SmartAssistant
//
//  Created by Louis.B on 2019/12/13.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import UIKit

protocol SelectViewControllerDelegate: NSObjectProtocol {
    func didSelectItem<Item>(_ item: Item)
}

class SelectCell<Model>: UITableViewCell {
    var model: Model?
    
    required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SelectViewController<Model, CellType: SelectCell<Model>>: SABaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    
    weak var delegate: SelectViewControllerDelegate?
    
    var dataSource = [Model]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        let views = ["tableView" : tableView as Any]
        var vfl = "H:|-0-[tableView]-0-|"
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: vfl,
                                                           metrics: nil,
                                                           views: views))
        vfl = "V:|-0-[tableView]-0-|"
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: vfl,
                                                           metrics: nil,
                                                           views: views))
    }
    
    // MARK: UITableViewDataSource & delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "selectCellId"
        var cell: CellType? = tableView.dequeueReusableCell(withIdentifier: identifier) as? CellType
        if cell == nil {
            cell = CellType.init(style: .default, reuseIdentifier: identifier)
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
        }
        cell?.model = dataSource[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        Log("\(dataSource[indexPath.row])")
        delegate?.didSelectItem(dataSource[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}
