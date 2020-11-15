//
//  CoreDataStack.swift
//  Daily.v2
//
//  Created by Бакулин Семен Александрович on 08.11.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//

import CoreData

final class CoreDataStack{
    
    private let modelName: String
    
    private lazy var persistentStoreUrlDescription: NSPersistentStoreDescription = {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let storeDecsriptions = NSPersistentStoreDescription(url: documentsUrl.appendingPathComponent("\(self.modelName).sqlite"))
        storeDecsriptions.type = NSSQLiteStoreType
        return storeDecsriptions
    }()
    
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.persistentStoreDescriptions = [persistentStoreUrlDescription]
        container.loadPersistentStores { (desc, err) in
            if let err = err {
                fatalError("Could not load persistent store: \(err)")
            }
        }
        return container
    }()
    
    public func mainContext()->NSManagedObjectContext{
        return container.viewContext
    }
    
    public lazy var backgroundContext: NSManagedObjectContext = {
        return self.container.newBackgroundContext()
    }()
    
    func saveContext(context: NSManagedObjectContext){
        guard context.hasChanges == true else { return }
        
        do{
            try context.save()
        }catch let err as NSError {
            fatalError("Could not save data, unexpected error: \(err)")
        }

    }
    
    init(modelName: String){
        self.modelName = modelName
    }
    
}
