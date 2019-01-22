//
//  LectorsViewController.swift
//  CoreDataExample
//
//  Created by Andrey Chuprina on 1/15/19.
//  Copyright © 2019 Andrey Chuprina. All rights reserved.
//

import UIKit
import CoreData

class LectorsViewController: ParentTableViewController {

    private lazy var context = CoreDataStack.shared.persistentContainer.viewContext
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Lector> = {
        let fetchRequest: NSFetchRequest<Lector> = Lector.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let controller = NSFetchedResultsController<Lector>(
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
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Surname"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak context] _ in
            guard let context = context else { return }
            
            let object = Lector(context: context)
            object.name = alert.textFields?.first?.text
            object.surname = alert.textFields?.last?.text
            try? context.save()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func editAction(indexPath: IndexPath) {
        guard let object = fetchedResultsController.fetchedObjects?[indexPath.row] else { return }
        
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
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak context] _ in
            object.name = alert.textFields?.first?.text
            object.surname = alert.textFields?.last?.text
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


extension LectorsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "Lector", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let object = fetchedResultsController.fetchedObjects?[indexPath.row]
        cell.textLabel?.text = object?.fullName
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return editActions
    }
    
}


extension LectorsViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
}
