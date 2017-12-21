//
//  ToDoListExtension.swift
//  SwiftTraning
//
//  Created by Vaibhav T. Indalkar on 20/12/17.
//  Copyright © 2017 Vaibhav Indalkar. All rights reserved.
//

import CoreData
import UIKit

extension ToDoList {
    
    func saveTask(task:[String:Any]) {
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context    = appdelegate.persistentContainer.viewContext
        let taskEntity = NSEntityDescription.entity(forEntityName: "ToDoList", in: context)
        let toDoTask   = NSManagedObject.init(entity: taskEntity!, insertInto: context)
        
    }
}
