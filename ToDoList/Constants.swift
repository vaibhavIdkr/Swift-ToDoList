//
//  Constants.swift
//  SwiftTraning
//
//  Created by Vaibhav Indalkar on 20/12/17.
//  Copyright © 2017 Vaibhav Indalkar. All rights reserved.
//

import UIKit

struct ScreenSize {
    
    static let width  = UIScreen.main.bounds.width;
    static let height = UIScreen.main.bounds.height;
}

enum pickerType {
    
}

struct ToDoDataModel {
    static let category       = "category"
    static let scheduleDate   = "reminderDate"
    static let additionalNote = "additionalNote"
    static let shouldRemind   = "shouldRemind"
    static let imageName      = "imageName"
}

