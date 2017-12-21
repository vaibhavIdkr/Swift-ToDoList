//
//  TaskListViewDataSource.swift
//  SwiftTraning
//
//  Created by Vaibhav T. Indalkar on 21/11/17.
//  Copyright © 2017 Vaibhav Indalkar. All rights reserved.
//

import UIKit

class TaskListViewDataSource: NSObject,UITableViewDataSource,UITableViewDelegate
{
    var selectedTaskCallback : ((_ task: String) -> ())?
    let cellIdentifier = "defaultCell"
    let dataStore = TasksDataSource ()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataStore.allTasks().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var defaultCell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if(defaultCell == nil){
            defaultCell = UITableViewCell (style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
        }
        
        defaultCell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        let task = dataStore.allTasks()[indexPath.row]
        
        defaultCell?.textLabel?.font = UIFont.init(name: "Roboto-Regular", size: 15.0)
        defaultCell?.textLabel?.textColor = UIColor.darkGray
        defaultCell!.textLabel!.text = task
        
        defaultCell?.selectionStyle = UITableViewCellSelectionStyle.none
        
        return defaultCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let taskCallback = selectedTaskCallback {
            taskCallback(dataStore.allTasks()[indexPath.row])
        }
    }
}

class TasksDataSource
{
    private var tasks = ["TO-Do List","Local Notification","Sqlite","Core Data","Animations","Date and Timers"];
    
    func allTasks() -> [String] {
        
        return tasks;
    }
    
}
