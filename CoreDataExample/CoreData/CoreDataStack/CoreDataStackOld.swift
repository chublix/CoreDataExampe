//
//  CoreDataStackOld.swift
//  CoreDataExample
//
//  Created by Andrey Chuprina on 1/13/19.
//  Copyright © 2019 Andrey Chuprina. All rights reserved.
//

import CoreData



class CoreDataStackOld {
    
    static let shared = CoreDataStackOld()
    
    private init() { }
    
    private(set) lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        guard let applicationSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            fatalError("Can't find application support directory url")
        }
        
        guard let modelURL = Bundle.main.url(forResource: "ExampleModel", withExtension: "momd") else {
            fatalError("Can't find url for specified model name")
        }
        
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error while loading model")
        }
        
        
        let storeURL = applicationSupportURL.appendingPathComponent("ExampleModel.sqlite")
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        do {
            _ = try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL)
        } catch {
            fatalError(error.localizedDescription)
        }
        return coordinator
    }()
    
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }()
    
}
