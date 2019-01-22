//
//  Student+CoreDataClass.swift
//  CoreDataExample
//
//  Created by Elena Chekhova on 1/13/19.
//  Copyright © 2019 Andrey Chuprina. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Student)
public class Student: Person {

    class func fetchAll(from context: NSManagedObjectContext = CoreDataStack.shared.persistentContainer.viewContext, ignoredName: String = "Andrey" ) -> [Student] {
        let request: NSFetchRequest<Student> = fetchRequest()
        request.predicate = NSPredicate(format: "name != %@", ignoredName)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let lectors = try? context.fetch(request)
        return lectors ?? []
    }
    
}
