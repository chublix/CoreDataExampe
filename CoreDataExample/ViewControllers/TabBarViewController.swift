//
//  TabBarViewController.swift
//  CoreDataExample
//
//  Created by Andrey Chuprina on 1/15/19.
//  Copyright © 2019 Andrey Chuprina. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override var selectedViewController: UIViewController? {
        didSet {
            navigationItem.title = selectedViewController?.title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addAction(_:)))
    }
    
    @objc private func addAction(_ sender: UIBarButtonItem) {
        (selectedViewController as? ParentTableViewController)?.addAction()
    }
    

}
