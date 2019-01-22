//
//  Mark+CoreDataClass.swift
//  CoreDataExample
//
//  Created by Elena Chekhova on 1/13/19.
//  Copyright © 2019 Andrey Chuprina. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Mark)
public class Mark: NSManagedObject {

    class func fetchAll(from context: NSManagedObjectContext = CoreDataStack.shared.persistentContainer.viewContext) -> [Mark] {
        let request: NSFetchRequest<Mark> = fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "student.name", ascending: true)]
        let lectors = try? context.fetch(request)
        return lectors ?? []
    }
    
}
