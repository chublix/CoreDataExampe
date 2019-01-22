//
//  Lecture+CoreDataClass.swift
//  CoreDataExample
//
//  Created by Elena Chekhova on 1/13/19.
//  Copyright © 2019 Andrey Chuprina. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Lecture)
public class Lecture: NSManagedObject {

    class func fetchAll(from context: NSManagedObjectContext = CoreDataStack.shared.persistentContainer.viewContext) -> [Lecture] {
        let request: NSFetchRequest<Lecture> = fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "theme", ascending: true)]
        let lectors = try? context.fetch(request)
        return lectors ?? []
    }
    
}

extension Lecture: ItemViewModel {
    
    var title: String? {
        return theme
    }
    
}
