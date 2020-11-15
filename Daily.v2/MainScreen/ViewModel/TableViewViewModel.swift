//
//  TableViewViewModel.swift
//  Daily.v2
//
//  Created by Бакулин Семен Александрович on 09.11.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import UIKit
import CoreData

class TableViewViewModel{
    
    public var tasks: [Task] {
        get{ return getAllTasks() }
    }
    
    lazy var fetchManager: FetchManager = FetchManager.shared
    
    public func performFetch(){
        fetchManager.fetchResultController.managedObjectContext.perform {
            do{
                try self.fetchManager.fetchResultController.performFetch()
            } catch let err as NSError {
                fatalError("Can not perform fetch: \(err)")
            }
        }
    }
    
    public func saveMainContext(){
        fetchManager.saveMainContext()
    }
    
    public func getAllTasks() -> [Task] {
        do{
            try fetchManager.fetchResultController.performFetch()
        }catch let err as NSError{
            fatalError("Could not fetch any objects \(err)")
        }
        var objectID = [NSManagedObjectID]()
        guard let objects = fetchManager.fetchResultController.fetchedObjects else { return [Task]() }
        
        for object in objects {
            objectID.append(object.objectID)
        }
        
        var mainObjects = [Task]()
        for obj in objectID{
            mainObjects.append(fetchManager.coreDataStack.mainContext().object(with:obj) as! Task)
        }
        
        return mainObjects
    }
    
    public func getCurrentTask(index: Int)->Task{
        return tasks[index]
    }
    
    public func deleteAllTasks(){
        fetchManager.deleteAllTask()
    }
    
    public func deleteTask(task: Task){
        fetchManager.deleteTask(object: task)
    }
    
    public func createTask(){
        fetchManager.createTask(text: "")
    }
}
