//
//  DateCollectionViewDataSource.swift
//  SwiftTraning
//
//  Created by Vaibhav T. Indalkar on 23/11/17.
//  Copyright © 2017 Vaibhav Indalkar. All rights reserved.
//

import UIKit

class DateCollectionViewDataSource: NSObject,UICollectionViewDataSource,UICollectionViewDelegate {

    let daysOfWeek  = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    var collectionViewCompletionCallback : (()->())?
    var cellIdentifier      : String?
    var daysInCurrentMonth  : Int?
    let currentDayOfMonth   : Int?
    let toDoViewModel = ToDoViewModel()
    
    init(cellIdentifier:String) {
        self.cellIdentifier = cellIdentifier
        self.daysInCurrentMonth = toDoViewModel.numberOfDaysInMonth()
        self.currentDayOfMonth  = toDoViewModel.currentDayOfMonth()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysInCurrentMonth!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier!, for: indexPath) as! DateColleCollectionViewCell
       
        cell.dayLabel.text  = CalenderData().dayFromIndexPath(index: indexPath)
        cell.dateLabel.text = "\(indexPath.row + 1)";
        
        if ((indexPath.row + 1) == self.currentDayOfMonth){
            cell.dateLabel.textColor           = UIColor.init(red: 124/255.0, green: 57/255.0, blue: 172/255.0, alpha: 1)
            cell.dateLabel.backgroundColor     = UIColor.white
            cell.dateLabel.layer.masksToBounds = true
            cell.dateLabel.layer.cornerRadius  = 10.0;
        }else{
            cell.dateLabel.textColor          = UIColor.white
            cell.dateLabel.backgroundColor    = UIColor.clear
            cell.dateLabel.layer.cornerRadius = 0.0;
        }
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? DateColleCollectionViewCell{
            cell.dateLabel.layer.cornerRadius = 10.0
        }
    }
}

class CalenderData {
    
    func dayFromIndexPath(index:IndexPath) -> String {
        
        let firstDateOfMonth = Date().startOfMonth()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE";
        
        var dateComponent = DateComponents()
        dateComponent.day = index.row + 1
        let computedDate  = Calendar.current.date(byAdding: .day, value: index.row, to: firstDateOfMonth!)
        let day           = dateFormatter.string(from: computedDate!)
        
        return day;
    }
}



