//
//  Task+CoreDataProperties.swift
//  ToDoList
//
//  Created by Vaibhav Indalkar on 26/12/17.
//  Copyright © 2017 Vaibhav Indalkar. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var reminderDate: NSDate?
    @NSManaged public var category: String?
    @NSManaged public var shouldRemind: Bool
    @NSManaged public var additionalNote: String?
    @NSManaged public var imageName: String?

}
