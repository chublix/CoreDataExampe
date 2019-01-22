//
//  Homework+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by Oleksandr on 1/17/19.
//  Copyright © 2019 Andrey Chuprina. All rights reserved.
//
//

import Foundation
import CoreData


extension Homework {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Homework> {
        return NSFetchRequest<Homework>(entityName: "Homework")
    }

    @NSManaged public var task: String?
    @NSManaged public var lecture: Lecture?
    @NSManaged public var marks: NSSet?

}

// MARK: Generated accessors for marks
extension Homework {

    @objc(addMarksObject:)
    @NSManaged public func addToMarks(_ value: Mark)

    @objc(removeMarksObject:)
    @NSManaged public func removeFromMarks(_ value: Mark)

    @objc(addMarks:)
    @NSManaged public func addToMarks(_ values: NSSet)

    @objc(removeMarks:)
    @NSManaged public func removeFromMarks(_ values: NSSet)

}
