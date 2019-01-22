//
//  CustomInputView.swift
//  CoreDataExample
//
//  Created by Andrey Chuprina on 1/16/19.
//  Copyright © 2019 Andrey Chuprina. All rights reserved.
//

import UIKit

protocol ItemViewModel: class {
    var title: String? { get }
}

class CustomInputView: UIInputView, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableFooterView = UIView()
        }
    }
    
    var listOfObjects: [ItemViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var selected: ItemViewModel? {
        didSet {
            onSelected?(selected)
        }
    }
    var onSelected: ((ItemViewModel?) -> Void)?
    var onDone: ((ItemViewModel?) -> Void)?

    class func loadFromXib() -> CustomInputView {
        let nib = UINib(nibName: "CustomInputView", bundle: nil)
        let view = nib.instantiate(withOwner: nil, options: nil).first as! CustomInputView
        return view
    }
    
    @IBAction private func done(_ sender: Any) {
        superview?.endEditing(true)
        onDone?(selected)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = listOfObjects[indexPath.row].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = listOfObjects[indexPath.row]
    }
    
}
