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
    
    // 오늘 날짜가 아닌 리스트는 제거
    func updateList() {
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let convertDate = dateFormatter.string(from: nowDate)
        
        if let context = context {
            let invalidList = self.list.filter({ (item) -> Bool in item.date != convertDate })
            for item in invalidList {
                context.delete(item)
            }
            do {
                try context.save()
            } catch {
                print("Colud not update list")
            }
        }
    }
    
    // Core Data에 저장된 Todo 데이터 가져오는 메서드
    func getTodos() {
        if let context = context {
            let sortDpt: NSSortDescriptor = NSSortDescriptor(key: "order", ascending: false)
            let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: modelName)
            fetchRequest.sortDescriptors = [sortDpt]
            
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
    
    // Core Data에 Todo 데이터 제거하는 메서드
    func deleteTodo(_ index: Int) {
        if let context = context {
            context.delete(self.list[index])
            self.list.remove(at: index)
            do {
                try context.save()
            } catch let error as NSError {
                print("Colud not delete: \(error), \(error.userInfo)")
            }
        }
    }
    
    // Core Data 순서 변경
    func moveRowTodo(fromIndex fIndex: Int, toIndex tIndex: Int) {
        let toOrder = self.list[tIndex].order
        self.list[tIndex].order = self.list[fIndex].order
        self.list[fIndex].order = toOrder
        if let context = context {
            do {
                try context.save()
            } catch let error as NSError {
                print("Colud not move row: \(error), \(error.userInfo)")
            }
        }
    }
}
