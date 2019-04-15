//
//  CoreData.swift
//  Trial
//
//  Created by Ahmed Sengab on 2/5/19.
//  Copyright © 2019 Ahmed Sengab. All rights reserved.
//

import UIKit
import CoreData

class NotesModeCoreData {
    private let modelName : String
    init(modelName : String)
    {
        self.modelName = modelName
    }
    ///// Context ///////
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    /////// Persistane conatiner
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext () {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let nserror as NSError {
            print("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
