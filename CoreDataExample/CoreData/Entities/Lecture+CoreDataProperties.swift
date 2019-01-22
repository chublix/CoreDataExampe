//
//  Lecture+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by Oleksandr on 1/17/19.
//  Copyright © 2019 Andrey Chuprina. All rights reserved.
//
//

import Foundation
import CoreData


extension Lecture {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lecture> {
        return NSFetchRequest<Lecture>(entityName: "Lecture")
    }

    @NSManaged public var theme: String?
    @NSManaged public var homeworks: NSSet?
    @NSManaged public var lector: Lector?
    @NSManaged public var attendecies: NSSet?

}

// MARK: Generated accessors for homeworks
extension Lecture {

    @objc(addHomeworksObject:)
    @NSManaged public func addToHomeworks(_ value: Homework)

    @objc(removeHomeworksObject:)
    @NSManaged public func removeFromHomeworks(_ value: Homework)

    @objc(addHomeworks:)
    @NSManaged public func addToHomeworks(_ values: NSSet)

    @objc(removeHomeworks:)
    @NSManaged public func removeFromHomeworks(_ values: NSSet)

}

// MARK: Generated accessors for attendecies
extension Lecture {

    @objc(addAttendeciesObject:)
    @NSManaged public func addToAttendecies(_ value: Attendcy)

    @objc(removeAttendeciesObject:)
    @NSManaged public func removeFromAttendecies(_ value: Attendcy)

    @objc(addAttendecies:)
    @NSManaged public func addToAttendecies(_ values: NSSet)

    @objc(removeAttendecies:)
    @NSManaged public func removeFromAttendecies(_ values: NSSet)

}
