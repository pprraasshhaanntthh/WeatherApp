//
//  CoreDataStack.swift
//  WeatherMobileApp
//
//  Created by Prashanth on 04/05/19.
//  Copyright © 2019 Prashanth. All rights reserved.
//

import Foundation
import CoreData

var settingsTable = [SettingsTable]()
let context = CoreDataStack().persistentContainer.viewContext


/// To perform the operations fror coredata such as save, delete or fetching container.
class CoreDataStack{
    
    /// to save the changes on view context for the coredata for storing data
    func save(){
        if context.hasChanges{
            do{
                try context.save()
                print("Save sacsesfully")
            }catch{
                print("Fatal error: \(error.localizedDescription)")
            }
        }
    }
    
    /// to delete a object in viewcontext for coredata
    ///
    /// - Parameter object: delete the object
    private func delete(_ object: NSManagedObject){
        context.delete(object)
        save()
    }

    /// to delete the parameters in the setting table
    func deleteParameters(){
        let typeTemp = settingsTable
        for deletFerst in typeTemp{
            delete(deletFerst)
        }
    }
    
    /// fetches the persistent container for the XCdatamodelId
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "WeatherMobileApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    /// to save the changes on view context for the coredata for storing data
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

