//
//  Attendcy+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by Oleksandr on 1/17/19.
//  Copyright © 2019 Andrey Chuprina. All rights reserved.
//
//

import Foundation
import CoreData


extension Attendcy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attendcy> {
        return NSFetchRequest<Attendcy>(entityName: "Attendcy")
    }

    @NSManaged public var present: Bool
    @NSManaged public var lecture: Lecture?
    @NSManaged public var student: Student?

}
