//
//  ItemViewController.swift
//  MyPricePal
//
//  Created by Brice Redmond on 4/19/19.
//  Copyright © 2019 CS48. All rights reserved.
//

import UIKit
import Anchors

public protocol ItemViewDismissalDelegate : class {
    func itemViewDidDismiss(_ controller: ItemViewController)
}

public class ItemViewController: UIViewController {

    public weak var dismissalDelegate: ItemViewDismissalDelegate?
    
    public var barcodeString: String? //Barcode string to send to firebase
    
//    var backButton: UIButton = {
//        let button = UIButton(frame: .zero)
//        button.setTitle("Scan", for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
//        button.tintColor = .black
//        button.setTitleColor(.black, for: .normal)
//        button.addTarget(self, action: #selector(dismissalAction), for: .touchUpInside)
//        return button
//    }()
    
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
    
    var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .white
        return navigationBar
    }()
    
    @objc func dismissalAction(sender: Any) {
        dismissalDelegate?.itemViewDidDismiss(self)
    }
    
    override open func loadView() {
        super.loadView()
        view.backgroundColor = .white
        navigationItem.titleView = titleLabel
        let backBarButton = UIBarButtonItem(title: "Scan", style: .plain, target: self, action: #selector(dismissalAction(sender:)))        
        navigationItem.leftBarButtonItem = backBarButton
        layoutViews()
    }
    
    func addNavigationBar() {
//        navigationItem.leftBarButtonItem = backButton
//        navigationItem.titleView = titleLabel
//
//        navigationBar.items = [navigationItem]

    }
    
    func layoutViews() {
        
        let textView = UITextView(frame: .zero)
        textView.text = barcodeString
        textView.textColor = .black
        textView.font = UIFont.boldSystemFont(ofSize: 25)
        textView.textAlignment = .center
        
        view.addSubview(textView)
        
        //Activates the layout between the UIs.
        activate(
//            navigationBar.anchor.left.right.equal.to(view.anchor.left.right),
//            navigationBar.anchor.top.equal.to(view.safeAreaLayoutGuide.anchor.top),
            
            textView.anchor.center.equal.to(view.safeAreaLayoutGuide.anchor.center),
            textView.anchor.width.equal.to(view.anchor.width).multiplier(3/5),
            textView.anchor.height.equal.to(textView.anchor.width).multiplier(1/2)
            
        )
    }
}
