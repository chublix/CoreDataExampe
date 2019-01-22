//
//  Student+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by Oleksandr on 1/17/19.
//  Copyright © 2019 Andrey Chuprina. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var marks: NSSet?
    @NSManaged public var attendcies: NSSet?

}

// MARK: Generated accessors for marks
extension Student {

    @objc(addMarksObject:)
    @NSManaged public func addToMarks(_ value: Mark)

    @objc(removeMarksObject:)
    @NSManaged public func removeFromMarks(_ value: Mark)

    @objc(addMarks:)
    @NSManaged public func addToMarks(_ values: NSSet)

    @objc(removeMarks:)
    @NSManaged public func removeFromMarks(_ values: NSSet)

}

// MARK: Generated accessors for attendcies
extension Student {

    @objc(addAttendciesObject:)
    @NSManaged public func addToAttendcies(_ value: Attendcy)

    @objc(removeAttendciesObject:)
    @NSManaged public func removeFromAttendcies(_ value: Attendcy)

    @objc(addAttendcies:)
    @NSManaged public func addToAttendcies(_ values: NSSet)

    @objc(removeAttendcies:)
    @NSManaged public func removeFromAttendcies(_ values: NSSet)

}
