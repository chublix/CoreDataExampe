//
//  Mark+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by Oleksandr on 1/17/19.
//  Copyright © 2019 Andrey Chuprina. All rights reserved.
//
//

import Foundation
import CoreData


extension Mark {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mark> {
        return NSFetchRequest<Mark>(entityName: "Mark")
    }

    @NSManaged public var clarification: String?
    @NSManaged public var mark: Int32
    @NSManaged public var homework: Homework?
    @NSManaged public var student: Student?

}
