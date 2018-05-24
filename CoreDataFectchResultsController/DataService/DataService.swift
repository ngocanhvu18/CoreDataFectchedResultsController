//
//  DataService.swift
//  CoreDataFectchResultsController
//
//  Created by Ngọc Anh on 5/24/18.
//  Copyright © 2018 NgocAnh. All rights reserved.
//

import UIKit
import CoreData

class DataService {
    static let share : DataService = DataService()
    var fetchResultController : NSFetchedResultsController<Entity> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        let fetchRequest : NSFetchRequest<Entity> = Entity.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        let sortDescriptor = NSSortDescriptor(key: "name", ascending : false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: AppDelegate.context, sectionNameKeyPath: nil, cacheName: "Master")
        _fetchedResultsController = aFetchedResultsController
        do{
            try _fetchedResultsController!.performFetch()
        }
        catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return _fetchedResultsController!
    }
    private var _fetchedResultsController: NSFetchedResultsController<Entity>? = nil
    
    // Save Data
    func saveToCoreData() {
        let context = _fetchedResultsController?.managedObjectContext
        do {
            try context?.save()
            print("Core Data Saved")
        } catch let error as NSError {
            print("\(error.userInfo)")
        }
    }
}
