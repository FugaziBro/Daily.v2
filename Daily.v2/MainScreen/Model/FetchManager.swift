//
//  FetchManager.swift
//  Daily.v2
//
//  Created by Бакулин Семен Александрович on 09.11.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import CoreData
import Foundation

class FetchManager{
    private(set) var coreDataStack: CoreDataStack
    private let dateSortDescriptor = NSSortDescriptor(key: #keyPath(Task.date), ascending: false)
    
    private lazy var tasksFetch: NSFetchRequest<Task> = {
        let fetch: NSFetchRequest<Task> = Task.fetchRequest()
        fetch.fetchBatchSize = 20
        fetch.sortDescriptors = [self.dateSortDescriptor]
        return fetch
    }()
    
    public func saveMainContext(){
        coreDataStack.saveContext(context: coreDataStack.mainContext())
    }
    
    public func saveBackgroundContext(){
        coreDataStack.saveContext(context: coreDataStack.backgroundContext)
    }
    
    public lazy var fetchResultController: NSFetchedResultsController<Task> = {
        let frc = NSFetchedResultsController(fetchRequest: self.tasksFetch, managedObjectContext: self.coreDataStack.backgroundContext , sectionNameKeyPath: #keyPath(Task.date), cacheName: nil)
        return frc
    }()
    
    public func createTask(text:String, date: Date = Date()){
        let task = Task(context: coreDataStack.mainContext())
        task.text = text
        task.date = date
        print("Task created: \(task.text!), \(date)")
        do{
            try coreDataStack.mainContext().save()
        }catch let err as NSError{
            fatalError("Could not save mainContext \(err)")
        }
    }
    
    public func deleteTask(object: NSManagedObject){
        coreDataStack.mainContext().delete(object)
        saveMainContext()
    }
    
    public func deleteAllTask(){
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: self.tasksFetch as! NSFetchRequest<NSFetchRequestResult>)
        do{
           try coreDataStack.mainContext().execute(batchDeleteRequest)
        }catch let err as NSError{
            fatalError("Could not execute delete request")
        }
        saveMainContext()
    }
    
    public static let shared: FetchManager = {
        return FetchManager(modelName: AppConfig.shared.modelName)
    }()
    
    private init(modelName:String){
        self.coreDataStack = CoreDataStack(modelName: modelName)
    }
}
