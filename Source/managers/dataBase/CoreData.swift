//
//  CoreData.swift
//  Weeteam
//
//  Created by Admin on 5/29/20.
//  Copyright © 2020 Роман Родителев. All rights reserved.
//

import Foundation
import CoreData

protocol Storable { }

extension Storable where Self: NSManagedObject {
    var stack: CoreData {
        return CoreData.stack
    }
}

extension NSManagedObject: Storable { }

final class CoreData {
    
    // MARK: - Stack
    private(set) static var stack = CoreData()
    
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NYTimes")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: - Contexts
    lazy var mainContext: NSManagedObjectContext = {
        return container.viewContext
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return container.newBackgroundContext()
    }()
    
    func saveContext() {
        guard mainContext.hasChanges else { return }
        
        do {
            try mainContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
