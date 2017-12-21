//
//  ToDoListViewController.swift
//  SwiftTraning
//
//  Created by Vaibhav T. Indalkar on 23/11/17.
//  Copyright © 2017 Vaibhav Indalkar. All rights reserved.
//

import UIKit
import Foundation

class ToDoListViewController: UIViewController{

    var reuseIdentifier:String = "collectionCell"
    let toDoViewModelInstance  = ToDoViewModel()
    var dateCollectionViewDataSource : DateCollectionViewDataSource?

    @IBOutlet weak var addReminderButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calenderCollectionView: UICollectionView!
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Things To-DO"
        
        dateCollectionViewDataSource = DateCollectionViewDataSource.init(cellIdentifier: reuseIdentifier)
        self.calenderCollectionView.dataSource      = dateCollectionViewDataSource
        self.calenderCollectionView.backgroundColor = UIColor.clear
        self.calenderCollectionView.register(UINib.init(nibName: "DateColleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        self.navigationController?.isNavigationBarHidden = true;
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.isStatusBarHidden = false;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        
        if let currentDate = dateCollectionViewDataSource?.currentDayOfMonth {
            let newIndexPath:IndexPath = IndexPath.init(row: currentDate - 1, section: 0);
            self.calenderCollectionView .scrollToItem(at: newIndexPath, at: .left, animated: true)
        }
        
        let animation = swingAnimation()
        addReminderButton.layer.add(animation, forKey: "rotation")
    }
    
    //MARK: Private methods
    private func configureUI() {
        
        if let dateString = toDoViewModelInstance.stringFromDate(){
             self.dateLabel.text = dateString
        }
        if let dayOfWeek = toDoViewModelInstance.dayOfWeekFromDate() {
            self.dayOfWeekLabel.text = dayOfWeek
        }
        if let month = toDoViewModelInstance.combinedMonthYearFromDate(){
            self.monthLabel.text = month
        }
        
        let gradientLayer = toDoViewModelInstance.gradientLayer(shouldBeHorizontal: true)
        gradientLayer.frame = self.topView.bounds
        self.topView.layer.insertSublayer(gradientLayer, at: 0)

    }
    
    private func swingAnimation() -> CABasicAnimation {
    
        let animation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animation.duration      = 0.12
        animation.repeatCount   = 2
        animation.autoreverses  = true
        animation.fromValue     = NSNumber.init(value:0)
        animation.toValue       = NSNumber.init(value:1.5708)
        
        return animation
    }
    
    //MARK: Button action methods
    
    @IBAction func presentAddToDoTaskViewController(_ sender: Any) {
        let newTaskVC = AddNewTaskViewController.init(nibName: "AddNewTaskViewController", bundle: nil)
        newTaskVC.modalPresentationStyle = .currentContext
        newTaskVC.modalTransitionStyle   = .crossDissolve
        self.present(newTaskVC, animated: true, completion: nil)
    }
}
