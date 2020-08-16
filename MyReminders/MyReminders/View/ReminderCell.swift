//
//  ReminderCell.swift
//  MyReminders
//
//  Created by nestoras neofytou on 12/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//

import UIKit

class ReminderCell : UITableViewCell {
    
    
    
    
    @IBOutlet weak var isCompletedView: UIView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var dateLable: UILabel!
    
    @IBOutlet weak var infoButton: UIButton!
    
    
    
    
    
    
    
    
    func update(reminder: Reminder, index: Int){
        titleLable.text = reminder.title
        
        infoButton.tag = index //for the editing
        
        //make reminder identifier round
        isCompletedView.layer.cornerRadius = isCompletedView.frame.size.width / 2.0
        isCompletedView.layer.borderColor = UIColor.lightGray.cgColor
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy hh:mma"
        dateLable.text = dateFormatter.string(from: reminder.date)
        
        if reminder.isCompleted {
            isCompletedView.backgroundColor = UIColor.green
        } else {
            isCompletedView.backgroundColor = UIColor.white
        }
        
    }
    
    
}
