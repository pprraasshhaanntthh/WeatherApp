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

class CoreDataStack{
    
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
    
    private func delete(_ object: NSManagedObject){
        context.delete(object)
        save()
    }

    func deleteParameters(){
        let typeTemp = settingsTable
        for deletFerst in typeTemp{
            delete(deletFerst)
        }
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "WeatherMobileApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
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

