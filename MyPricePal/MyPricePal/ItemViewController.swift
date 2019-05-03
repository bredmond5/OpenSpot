//
//  ItemViewController.swift
//  MyPricePal
//
//  Created by Brice Redmond on 4/19/19.
//  Copyright © 2019 CS48. All rights reserved.
//

import UIKit
import Anchors

protocol ItemViewDismissalDelegate : class {
    func itemViewDidDismiss(_ controller: ItemViewController)
}

class ItemViewController: UITableViewController {
    
    var items: [String] = []

    public weak var dismissalDelegate: ItemViewDismissalDelegate?
//    public let textView = UITextView(frame: .zero)
    public var itemN: String?
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lays Potato Chips"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
//    var navigationBar: UINavigationBar = {
//        let navigationBar = UINavigationBar()
//        navigationBar.isTranslucent = false
//        navigationBar.backgroundColor = .white
//        return navigationBar
//    }()
    
    @objc func dismissalAction(sender: Any) {
        dismissalDelegate?.itemViewDidDismiss(self)
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        navigationItem.titleView = titleLabel
        let backBarButton = UIBarButtonItem(title: "Scan", style: .plain, target: self, action: #selector(dismissalAction(sender:)))        
        navigationItem.leftBarButtonItem = backBarButton
        items.append(itemN!)
  //      layoutViews()
    }
    
    override func viewDidLoad() {
        tableView.register(ItemViewItemCell.self, forCellReuseIdentifier: "itemCellId")
        tableView.register(ItemViewHeader.self, forHeaderFooterViewReuseIdentifier: "itemHeaderId")
        
         tableView.sectionHeaderHeight = 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: "itemCellId", for: indexPath) as! ItemViewItemCell
        itemCell.nameLabel.text = items[indexPath.row]
        itemCell.itemViewController = self
        return itemCell
    }
    
    func deleteCell(cell: UITableViewCell) {
        if let deletionIndexPath = tableView.indexPath(for: cell) {
            items.remove(at: deletionIndexPath.row)
            tableView.deleteRows(at: [deletionIndexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "itemHeaderId")
    }
    
//    func layoutViews() {
//
//        textView.textColor = .black
//        textView.font = UIFont.boldSystemFont(ofSize: 25)
//        textView.textAlignment = .center
//        textView.text = barcodeString
//        view.addSubview(textView)
//
////        let alertButton = UIButton(frame: .zero);
////        alertButton.addTarget(self, action: #selector(showAlertButtonTapped(_:)), for: .touchUpInside)
//
//        activate(
//            textView.anchor.center.equal.to(view.safeAreaLayoutGuide.anchor.center),
//            textView.anchor.width.equal.to(view.anchor.width).multiplier(3/5),
//            textView.anchor.height.equal.to(textView.anchor.width).multiplier(1/2)
//
//
//        )
//    }
}

class ItemViewHeader: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been initialized")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Similar Items"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Search"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        return textField
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addSubview(textField)
        activate(
            textField.anchor.center,
            textField.anchor.top.bottom
        )
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[v0]-12-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": nameLabel]))
    }
}

class ItemViewItemCell: UITableViewCell {
    
    var itemViewController: ItemViewController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been initialized")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Item"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addSubview(actionButton)
        
        actionButton.addTarget(self, action: #selector(handleAction(sender:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-8-[v1(80)]-8-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": nameLabel, "v1": actionButton]))
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[v0]-12-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[v0]-12-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": actionButton]))
    }
    
    @objc func handleAction(sender: UIButton) {
        itemViewController?.deleteCell(cell: self)
    }
}
