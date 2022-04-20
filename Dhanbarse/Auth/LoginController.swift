//
//  LoginController.swift
//  HrApp
//
//  Created by Goldmedal on 7/18/19.
//  Copyright © 2019 Goldmedal. All rights reserved.
//

import UIKit
import FSCalendar

class LoginController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    fileprivate weak var calendar: FSCalendar!
    var weekmode = false
    
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    
    
    let fillDefaultColors = ["2015/10/08": UIColor.purple, "2015/10/06": UIColor.green, "2015/10/18": UIColor.cyan, "2015/10/22": UIColor.yellow, "2015/11/08": UIColor.purple, "2015/11/06": UIColor.green, "2015/11/18": UIColor.cyan, "2015/11/22": UIColor.yellow, "2015/12/08": UIColor.purple, "2015/12/06": UIColor.green, "2015/12/18": UIColor.cyan, "2015/12/22": UIColor.magenta]
    
    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.groupTableViewBackground
        self.view = view
        
        let height: CGFloat = UIDevice.current.model.hasPrefix("iPad") ? 450 : 300
        let calendar = FSCalendar(frame: CGRect(x:0, y:64, width:self.view.bounds.size.width, height:height))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.allowsMultipleSelection = false
        calendar.swipeToChooseGesture.isEnabled = true
        calendar.backgroundColor = UIColor.white
        calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]
        
        self.view.addSubview(calendar)
        self.calendar = calendar
        calendar.select(self.dateFormatter1.date(from: "2015/10/03"))
        let todayItem = UIBarButtonItem(title: "TODAY", style: .plain, target: self, action: #selector(self.todayItemClicked(sender:)))
        self.navigationItem.rightBarButtonItem = todayItem
        
        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"
    }
    
    deinit {
        print("\(#function)")
    }
    
    @objc
    func todayItemClicked(sender: AnyObject) {
        if(weekmode){
            calendar.scope = .month
            weekmode = false
            calendar.rowHeight = 300.0
        }else{
            calendar.scope = .week
            weekmode = true
            calendar.rowHeight = 60.0
        }
        
    }
    
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let key = self.dateFormatter1.string(from: date)
        if let color = self.fillDefaultColors[key] {
            return UIColor.white
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        let key = self.dateFormatter1.string(from: date)
        if let color = self.fillDefaultColors[key] {
            return color
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let key = self.dateFormatter1.string(from: date)
        if let color = self.fillDefaultColors[key] {
            return color
        }
        return nil
    }
    
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
        
        return 1.0
    }
    
    
    @IBAction func onClick(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
        let vcForgotPassword = storyBoard.instantiateViewController(withIdentifier: "ForgotPasswordController") as! ForgotPasswordController
        self.navigationController!.pushViewController(vcForgotPassword, animated: true)
    }
}
