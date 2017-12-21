//
//  TimePickerViewController.swift
//  SwiftTraning
//
//  Created by Vaibhav Indalkar on 18/12/17.
//  Copyright © 2017 Vaibhav Indalkar. All rights reserved.
//

import UIKit

struct ClassConstants {
    static let deltaSize:CGFloat = 20;
}

class TimePickerViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var timePickerView: UIPickerView!
    var didPickTimeForReminderCallback : ((_ hours : Int ,_ minutes : Int) -> ())?
    
    let toDoViewModel = ToDoViewModel()
    let pickerOneData = TimePickerDataSource().numberOfRowsForPickerOne()
    let pickerTwoData = TimePickerDataSource().numberOfRowsForPickerTwo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePickerView.delegate = self
        timePickerView.dataSource = self
    }

    //MARK: - Picker view Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        pickerView.subviews.forEach({
            $0.isHidden = $0.frame.height < 1.0
        })
        
        return 2;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return pickerOneData.count
        }else {
            return pickerTwoData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return (pickerView.frame.size.width - ClassConstants.deltaSize) / 2;
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 130;
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerViewLabel = view as? UILabel
        
        if pickerViewLabel == nil {
            pickerViewLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: (pickerView.frame.size.width - ClassConstants.deltaSize) / 2, height: 130))
            pickerViewLabel?.font = UIFont.init(name: "Roboto-Medium", size: 40)
            pickerViewLabel?.textColor = UIColor.white
            pickerViewLabel?.textAlignment = .center
        }
        
        switch component {
        case 0:
            pickerViewLabel?.text = pickerOneData[row];
        case 1:
            pickerViewLabel?.text = pickerTwoData[row];
        default:
            break
        }
        return pickerViewLabel!
    }
    
    //Mark: - Button action methods

    @IBAction func onBackButtonTapped(_ sender: Any) {
        
        if let timePickCallback = didPickTimeForReminderCallback {
            let hours = (pickerOneData[timePickerView.selectedRow(inComponent: 0)] as NSString).integerValue
            let minutes = (pickerTwoData[timePickerView.selectedRow(inComponent: 1)] as NSString).integerValue
            
            timePickCallback(hours,minutes)
        }
        self.dismiss(animated: true, completion: nil)
    }
}

class TimePickerDataSource {
    
    func numberOfRowsForPickerOne() -> [String] {
        
        var rowOneDataArray = [String]()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh"
        if let time = Date().dateWithFormatter(formatter:formatter) {
            let time = (time as NSString).integerValue
            for rowIndex in time..<24 {
                rowOneDataArray.append("\(rowIndex)")
            }
        }
        return rowOneDataArray;
    }
    
    func numberOfRowsForPickerTwo() -> [String]  {
        
        var rowTwoDataArray = [String]()
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        
        if let minutes = Date().dateWithFormatter(formatter: formatter){
            
            let minutesForPicker = (minutes as NSString).integerValue + 5
            for rowIndex in minutesForPicker..<60 {
                rowTwoDataArray.append("\(rowIndex)")
            }
        }
        return rowTwoDataArray
    }
}
