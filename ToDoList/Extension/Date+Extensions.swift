//
//  Date+Extensions.swift
//  SwiftTraning
//
//  Created by Vaibhav Indalkar on 17/12/17.
//  Copyright © 2017 Vaibhav Indalkar. All rights reserved.
//

import Foundation

public extension Date {
    
    func daysInCurrentMonth() -> Int? {
        
        let dateRange = Calendar.current.range(of: .day, in: .month, for: Date())
        let days      = dateRange?.count
        return days!
    }
    
    func dateWithFormatter(formatter:DateFormatter) -> String? {
        return formatter.string(from: Date())
    }
    
    func currentDay() -> Int? {
        
        let dateComponent:DateComponents = Calendar.current.dateComponents([.year,.month,.day], from: self)
        return dateComponent.day!
    }
    
    func startOfMonth() -> Date? {
        
        let components:NSDateComponents = Calendar.current.dateComponents([.year,.month,], from: self) as NSDateComponents
        let componentDate = Calendar.current.date(from: components as DateComponents)
        
        return Calendar.current.date(byAdding: .day, value: 0, to: componentDate!)
    }
    
    func lastDayOfMonth() -> Date? {
        
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth()!)!
    }
    
}
