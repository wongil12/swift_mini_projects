//
//  Todos+CoreDataProperties.swift
//  TodoList
//
//  Created by Wongil on 2022/03/19.
//
//

import Foundation
import CoreData


extension Todos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todos> {
        return NSFetchRequest<Todos>(entityName: "Todos")
    }

    @NSManaged public var title: String?

}

extension Todos : Identifiable {

}
