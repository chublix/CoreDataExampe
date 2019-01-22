//
//  StudentsViewController.swift
//  CoreDataExample
//
//  Created by Andrey Chuprina on 1/15/19.
//  Copyright © 2019 Andrey Chuprina. All rights reserved.
//

import UIKit
import CoreData

class StudentsViewController: ParentTableViewController {

    private lazy var context = CoreDataStack.shared.persistentContainer.viewContext

    var students = Student.fetchAll() {
        didSet {
            tableView.reloadData()
        }
    }

    private lazy var editActions = [
        UITableViewRowAction(style: .normal, title: "Edit", handler: { [weak self] (_, indexPath) in
            self?.editAction(indexPath: indexPath)
        }),
        UITableViewRowAction(style: .destructive, title: "Delete", handler: { [weak self] (_, indexPath) in
            self?.deleteAction(indexPath: indexPath)
        })
    ]
    
    override func addAction() {
        let alert = UIAlertController(title: "Add new", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Surname"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak context, weak self] _ in
            guard let context = context else { return }
            
            let object = Student(context: context)
            object.name = alert.textFields?.first?.text
            object.surname = alert.textFields?.last?.text
            try? context.save()
            self?.students = Student.fetchAll()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func editAction(indexPath: IndexPath) {
        let object = students[indexPath.row]
        let alert = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
            textField.text = object.name
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Surname"
            textField.text = object.surname
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak context, weak self] _ in
            object.name = alert.textFields?.first?.text
            object.surname = alert.textFields?.last?.text
            try? context?.save()
            self?.students = Student.fetchAll()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func deleteAction(indexPath: IndexPath) {
        let object = students[indexPath.row]
        let alert = UIAlertController(title: "Delete?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [weak context, weak self] _ in
            context?.delete(object)
            try? context?.save()
            self?.students = Student.fetchAll()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MarksViewController {
            vc.student = sender as? Student
        }
    }
    
}


extension StudentsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "Student", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let object = students[indexPath.row]
        cell.textLabel?.text = object.fullName
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return editActions
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = students[indexPath.row]
        performSegue(withIdentifier: "showMarks", sender: object)
    }
    
}
