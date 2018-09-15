//
//  CoreDataManager.swift
//  CoreDataApp
//
//  Created by Victor Lee on 14/9/18.
//  Copyright © 2018 VictorLee. All rights reserved.
//

import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager() // will live forever as long as your app is alive, its properties will to
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Company")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed: \(error)")
            }
        }
        return container
    }()
    
    
    
}
