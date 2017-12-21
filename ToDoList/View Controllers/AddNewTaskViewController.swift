//
//  AddNewTaskViewController.swift
//  SwiftTraning
//
//  Created by Vaibhav T. Indalkar on 24/11/17.
//  Copyright © 2017 Vaibhav Indalkar. All rights reserved.
//

import UIKit

class AddNewTaskViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var taskCategoryTextField: UITextField!
    @IBOutlet weak var taskDescriptionTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var reminderSwitch: UISwitch!
    @IBOutlet weak var scheduleTaskButton: UIButton!
    @IBOutlet weak var bottomScheduleButtonConstraint: NSLayoutConstraint!
    let pickderViewDataSource = TimePickerDataSource()
    let toDoViewModel = ToDoViewModel()
    
    
    //MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
                
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd , yyyy";
        
        if let currentDate = Date().dateWithFormatter(formatter: formatter) {
            self.dateTextField.text = currentDate
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        UIView.animate(withDuration: 0.4, animations: {
            self.bottomScheduleButtonConstraint.constant = 13
            self.view.layoutIfNeeded()
        });
    }
    
    func setupUI() {
        
        UIApplication.shared.isStatusBarHidden = true

        reminderSwitch.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        
        addShadow(shadowView: addTaskButton)
        addShadow(shadowView: taskView)
        
        let gradientLayer = toDoViewModel.gradientLayer(shouldBeHorizontal: false)
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        taskCategoryTextField.rightView     = toDoViewModel.imageViewWithImage(image: #imageLiteral(resourceName: "downArrow"))
        taskCategoryTextField.rightViewMode = .always
        timeTextField.rightView         = toDoViewModel.imageViewWithImage(image: #imageLiteral(resourceName: "rightArrow"))
        timeTextField.rightViewMode     = .always
    }
    
    func addShadow(shadowView:UIView) -> (){
    
        shadowView.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha:0.3).cgColor
        shadowView.layer.shadowOffset = CGSize(width: 2.0, height: 5.0)
        shadowView.layer.shadowOpacity = 1.0
        shadowView.layer.shadowRadius = 4.0
    }
    
    //MARK: - Delegates
    //MARK:  Textfield
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case timeTextField:
            
            let timePickerVC = TimePickerViewController.init(nibName: "TimePickerViewController", bundle: nil)
            timePickerVC.didPickTimeForReminderCallback = { hours,minutes in
                self.timeTextField.text = "\(hours):\(minutes)"
            }
            self.present(timePickerVC, animated: true, completion: nil)
            return false
            
        case taskCategoryTextField:
            
            presentCategoryActionSheet()
            return false
            
        default:
            break;
        }
        
        return true
    }
    
    //MARK: - Button action
    @IBAction func onAddTaskButtonTapped(_ sender: Any) {
        
        if taskViewValidated() {
            showAlertWithMessage(message: "valid view")
        }
    }
    
    @IBAction func onDismissViewControllerButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
    }
    
    //MARK: - Private Methods
    func presentCategoryActionSheet() {
        
        let categories = toDoViewModel.getReminderCategories()
        let categoryActionSheet = UIAlertController.init(title: "Pick Categories", message: "", preferredStyle: .actionSheet)
        
        for alertCategory in categories {
            let alertAction = UIAlertAction.init(title: alertCategory, style: .default, handler: {(alertAction : UIAlertAction) in
                self.taskCategoryTextField.text = alertCategory
                categoryActionSheet.dismiss(animated: true, completion:nil)
            })
            categoryActionSheet.addAction(alertAction)
        }
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (action:UIAlertAction) in
            categoryActionSheet.dismiss(animated: true, completion: nil)
        })
        
        categoryActionSheet.addAction(cancelAction)
        
        self.present(categoryActionSheet, animated: true, completion: nil)
    }
    
    func showAlertWithMessage(message:String) {
        
        let alertController = UIAlertController.init(title: "Error!!", message: message, preferredStyle: .alert)
        let alertAction      = UIAlertAction.init(title: "OK", style: .cancel, handler: {(action:UIAlertAction) in
            alertController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(alertAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func taskViewValidated() -> Bool {
        
        if (taskCategoryTextField.text?.isEmpty)! {
            showAlertWithMessage(message: "Please choose reminder category.")
            return false
        }else if reminderSwitch.isOn && (timeTextField.text?.isEmpty)! {
            showAlertWithMessage(message: "Please set the time for reminder.")
            return false
        }
        
        return true
    }
}
