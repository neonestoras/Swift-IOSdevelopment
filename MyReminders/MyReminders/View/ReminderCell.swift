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
    
    func update(reminder: Reminder){
        titleLable.text = reminder.title
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
