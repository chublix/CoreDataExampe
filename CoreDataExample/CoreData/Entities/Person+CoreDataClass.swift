//
//  Person+CoreDataClass.swift
//  CoreDataExample
//
//  Created by Elena Chekhova on 1/13/19.
//  Copyright © 2019 Andrey Chuprina. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {

    var fullName: String {
        return [name, surname].compactMap { $0 }.joined(separator: " ")
    }
    
}

extension Person: ItemViewModel {
    
    var title: String? {
        return fullName
    }
    
}
