//
//  MarksViewController.swift
//  CoreDataExample
//
//  Created by Andrey Chuprina on 1/15/19.
//  Copyright © 2019 Andrey Chuprina. All rights reserved.
//

import UIKit
import CoreData

class MarksViewController: UITableViewController {

    var student: Student!
    
    private lazy var context = CoreDataStack.shared.persistentContainer.viewContext
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Mark> = {
        let fetchRequest: NSFetchRequest<Mark> = Mark.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "homework.lecture.theme", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "student == %@", student)
        let controller = NSFetchedResultsController<Mark>(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        controller.delegate = self
        try? controller.performFetch()
        return controller
    }()
    
    private lazy var editActions = [
        UITableViewRowAction(style: .normal, title: "Edit", handler: { [weak self] (_, indexPath) in
            self?.editAction(indexPath: indexPath)
        }),
        UITableViewRowAction(style: .destructive, title: "Delete", handler: { [weak self] (_, indexPath) in
            self?.deleteAction(indexPath: indexPath)
        })
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        navigationItem.title = "Marks"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
    }
    
    @objc private func addAction() {
        let alert = UIAlertController(title: "Add new", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Mark"
            textField.keyboardType = .numberPad
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Clarification"
        }
        
        let inpuView = CustomInputView.loadFromXib()
        inpuView.listOfObjects = Homework.fetchAll()
        inpuView.onDone = { [weak alert] _ in
            alert?.view.endEditing(true)
        }
        inpuView.onSelected = { selected in
            alert.textFields?[2].text = selected?.title
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Homework"
            textField.inputView = inpuView
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak context, weak student] _ in
            guard let context = context else { return }
            
            let object = Mark(context: context)
            object.mark = Int32(alert.textFields?[0].text ?? "") ?? 0
            object.clarification = alert.textFields?[1].text
            object.homework = inpuView.selected as? Homework
            object.student = student
            try? context.save()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func editAction(indexPath: IndexPath) {
        guard let object = fetchedResultsController.fetchedObjects?[indexPath.row] else { return }
        
        let alert = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Mark"
            textField.text = "\(object.mark)"
            textField.keyboardType = .numberPad
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Clarification"
            textField.text = object.clarification
        }
        
        let inpuView = CustomInputView.loadFromXib()
        inpuView.listOfObjects = Homework.fetchAll()
        inpuView.selected = object.homework
        inpuView.onDone = { [weak alert] _ in
            alert?.view.endEditing(true)
        }
        inpuView.onSelected = { selected in
            alert.textFields?[2].text = selected?.title
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Homework"
            textField.inputView = inpuView
            textField.text = object.homework?.title
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak context] _ in
            object.mark = Int32(alert.textFields?[0].text ?? "") ?? 0
            object.clarification = alert.textFields?[1].text
            object.homework = inpuView.selected as? Homework
            try? context?.save()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func deleteAction(indexPath: IndexPath) {
        guard let object = fetchedResultsController.fetchedObjects?[indexPath.row] else { return }
        
        let alert = UIAlertController(title: "Delete?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [weak context] _ in
            context?.delete(object)
            try? context?.save()
        }))
        present(alert, animated: true, completion: nil)
    }
    
}


extension MarksViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "Mark", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let object = fetchedResultsController.fetchedObjects?[indexPath.row]
        cell.textLabel?.text = "\(object?.mark ?? 0)"
        cell.detailTextLabel?.text = object?.clarification
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return editActions
    }
    
}


extension MarksViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
}
