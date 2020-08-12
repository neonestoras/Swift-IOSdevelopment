//
//  Reminder.swift
//  MyReminders
//
//  Created by nestoras neofytou on 12/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//

import Foundation

class Reminder{
    //variables
    var title: String
    var date:Date
    var isCompleted: Bool
    
    //constructor
    init(title:String, date:Date, isCompleted: Bool){
        self.title = title
        self.date = date
        self.isCompleted = isCompleted
    }
}
