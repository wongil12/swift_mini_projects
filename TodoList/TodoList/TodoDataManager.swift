//
//  TodoDataManager.swift
//  TodoList
//
//  Created by Wongil on 2022/03/19.
//

import UIKit
import CoreData

class TodoDataManager {
    static let shared: TodoDataManager = TodoDataManager()
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "Todos"
    
    func getTodos() -> [Todos] {
        var models: [Todos] = [Todos]()
        
        if let context = context {
            let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: modelName)
            
            do {
                if let fetchResult: [Todos] = try context.fetch(fetchRequest) as? [Todos] {
                    models = fetchResult
                }
            } catch let error as NSError {
                print("Colud not fetch: \(error), \(error.userInfo)")
            }
        }
        
        return models
    }
}
