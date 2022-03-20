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
    
    var list = [Todos]()
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "Todos"
    
    // Core Data에 저장된 Todo 데이터 가져오는 메서드
    func getTodos() {
        if let context = context {
            let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: modelName)
            
            do {
                if let fetchResult: [Todos] = try context.fetch(fetchRequest) as? [Todos] {
                    self.list = fetchResult
                }
            } catch let error as NSError {
                print("Colud not fetch: \(error), \(error.userInfo)")
            }
        }
    }
    
    // Core Data에 Todo 데이터 저장하는 메서드
    func saveTodo(_ text: String) {
        if let context = context, let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: modelName, in: context) {
            if let todo: Todos = NSManagedObject(entity: entity, insertInto: context) as? Todos {
                
                // idx와 order 채번
                let maxIdx = self.list.map( {(value: Todos) -> Int in Int(value.idx)} ).max()
                let maxOrder = self.list.map( {(value: Todos ) -> Int in Int(value.order)} ).max()
                
                let idx = maxIdx == nil ? 1 : maxIdx! + 1
                let order = maxOrder == nil ? 1 : maxOrder! + 1
                
                todo.setValue(text, forKey: "title")
                todo.setValue(idx, forKey: "idx")
                todo.setValue(order, forKey: "order")
                
                do {
                    try context.save()
                } catch let error as NSError {
                    print("Colud not fetch: \(error), \(error.userInfo)")
                }
            }
        }
    }
    
}
