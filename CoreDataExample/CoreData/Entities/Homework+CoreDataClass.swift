//
//  Homework+CoreDataClass.swift
//  CoreDataExample
//
//  Created by Elena Chekhova on 1/13/19.
//  Copyright © 2019 Andrey Chuprina. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Homework)
public class Homework: NSManagedObject {

    class func fetchAll(from context: NSManagedObjectContext = CoreDataStack.shared.persistentContainer.viewContext) -> [Homework] {
        let request: NSFetchRequest<Homework> = fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "lecture.theme", ascending: true)]
        let lectors = try? context.fetch(request)
        return lectors ?? []
    }
    
}


extension Homework: ItemViewModel {
    
    var title: String? {
        return [task, lecture?.theme].compactMap { $0 }.joined(separator: " – ")
    }
    
}
