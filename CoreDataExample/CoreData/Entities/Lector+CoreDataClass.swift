//
//  Lector+CoreDataClass.swift
//  CoreDataExample
//
//  Created by Elena Chekhova on 1/13/19.
//  Copyright © 2019 Andrey Chuprina. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Lector)
public class Lector: Person {

    class func fetchAll(from context: NSManagedObjectContext = CoreDataStack.shared.persistentContainer.viewContext) -> [Lector] {
        let request: NSFetchRequest<Lector> = fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let lectors = try? context.fetch(request)
        return lectors ?? []
    }
    
}
