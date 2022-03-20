//
//  Todos+CoreDataProperties.swift
//  TodoList
//
//  Created by Wongil on 2022/03/20.
//
//

import Foundation
import CoreData


extension Todos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todos> {
        return NSFetchRequest<Todos>(entityName: "Todos")
    }

    @NSManaged public var title: String?
    @NSManaged public var idx: Int16
    @NSManaged public var order: Int16

}

extension Todos : Identifiable {

}
