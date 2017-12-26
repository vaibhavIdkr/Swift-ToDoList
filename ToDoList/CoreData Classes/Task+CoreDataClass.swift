//
//  Task+CoreDataClass.swift
//  ToDoList
//
//  Created by Vaibhav Indalkar on 26/12/17.
//  Copyright © 2017 Vaibhav Indalkar. All rights reserved.
//
//

import UIKit
import CoreData


public class Task: NSManagedObject {

    private func getContext() -> NSManagedObjectContext {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        return appdelegate.persistentContainer.viewContext
    }
    
    func saveTask(category:String,additionalNote:String?,scheduleDate:Date,shouldRemind:Bool,imageName:String?) -> Bool {
        
        let context         = getContext()
        let taskEntity      = NSEntityDescription.entity(forEntityName: "Task", in: context)
        let managedObject   = NSManagedObject.init(entity: taskEntity!, insertInto: context)
        
        managedObject.setValue(category, forKey: ToDoDataModel.category)
        managedObject.setValue(additionalNote, forKey: ToDoDataModel.additionalNote)
        managedObject.setValue(scheduleDate, forKey: ToDoDataModel.scheduleDate)
        managedObject.setValue(shouldRemind, forKey: ToDoDataModel.shouldRemind)
        managedObject.setValue(imageName, forKey: ToDoDataModel.imageName)

        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func fetchTasks() -> [Task]? {
        let context = getContext()
        var data:[Task]?
        
        do {
            try data = context.fetch(Task.fetchRequest())
            return data
        } catch {
            return data
        }
    }
}
