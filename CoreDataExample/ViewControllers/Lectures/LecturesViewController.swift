//
//  LecturesViewController.swift
//  CoreDataExample
//
//  Created by Andrey Chuprina on 1/15/19.
//  Copyright © 2019 Andrey Chuprina. All rights reserved.
//

import UIKit
import CoreData

class LecturesViewController: ParentTableViewController {
    
    private lazy var context = CoreDataStack.shared.persistentContainer.viewContext
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Lecture> = {
        let fetchRequest: NSFetchRequest<Lecture> = Lecture.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "theme", ascending: true)]
        let controller = NSFetchedResultsController<Lecture>(
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
    
    override func addAction() {
        let alert = UIAlertController(title: "Add new", message: nil, preferredStyle: .alert)
        
        let inpuView = CustomInputView.loadFromXib()
        inpuView.listOfObjects = Lector.fetchAll()
        inpuView.onDone = { [weak alert] _ in
            alert?.view.endEditing(true)
        }
        inpuView.onSelected = { selected in
            alert.textFields?.last?.text = selected?.title
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Theme"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Select lector"
            textField.inputView = inpuView
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak context] _ in
            guard let context = context else { return }
            let object = Lecture(context: context)
            object.theme = alert.textFields?.first?.text
            object.lector = inpuView.selected as? Lector
            try? context.save()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func editAction(indexPath: IndexPath) {
        guard let object = fetchedResultsController.fetchedObjects?[indexPath.row] else { return }
        
        let alert = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
        
        let inpuView = CustomInputView.loadFromXib()
        inpuView.listOfObjects = Lector.fetchAll()
        inpuView.selected = object.lector
        inpuView.onDone = { [weak alert] _ in
            alert?.view.endEditing(true)
        }
        inpuView.onSelected = { selected in
            alert.textFields?.last?.text = selected?.title
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Theme"
            textField.text = object.theme
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Select lector"
            textField.text = object.lector?.fullName
            textField.inputView = inpuView
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak context] _ in
            object.theme = alert.textFields?.first?.text
            object.lector = inpuView.selected as? Lector
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


extension LecturesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "Lecture", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let object = fetchedResultsController.fetchedObjects?[indexPath.row]
        cell.textLabel?.text = object?.theme
        cell.detailTextLabel?.text = object?.lector?.fullName
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return editActions
    }
    
}


extension LecturesViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
}
