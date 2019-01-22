//
//  Lector+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by Oleksandr on 1/17/19.
//  Copyright © 2019 Andrey Chuprina. All rights reserved.
//
//

import Foundation
import CoreData


extension Lector {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lector> {
        return NSFetchRequest<Lector>(entityName: "Lector")
    }

    @NSManaged public var lectures: NSSet?

}

// MARK: Generated accessors for lectures
extension Lector {

    @objc(addLecturesObject:)
    @NSManaged public func addToLectures(_ value: Lecture)

    @objc(removeLecturesObject:)
    @NSManaged public func removeFromLectures(_ value: Lecture)

    @objc(addLectures:)
    @NSManaged public func addToLectures(_ values: NSSet)

    @objc(removeLectures:)
    @NSManaged public func removeFromLectures(_ values: NSSet)

}
