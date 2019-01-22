//
//  CoreDataStack.swift
//  CoreDataExample
//
//  Created by Andrey Chuprina on 1/13/19.
//  Copyright © 2019 Andrey Chuprina. All rights reserved.
//

import CoreData


class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    private init() { }
    
    private(set) lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ExampleModel")
        container.loadPersistentStores(completionHandler: { (persistentStoreDescription, error) in
            if let error = error {
                debugPrint(error)
                return
            }
            debugPrint(persistentStoreDescription)
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        })
        return container
    }()
    
}
