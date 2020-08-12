//
//  ReminderService.swift
//  MyReminders
//
//  Created by nestoras neofytou on 12/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//

import Foundation

class ReminderService{
    
    static let share = ReminderService()
    
    private var reminders = [Reminder]()
    
    //Create
    func create(reminder: Reminder){
        reminders.append(reminder)
    }
    
    //Update
    func update(reminder: Reminder, index: Int){
        reminders[index] = reminder
    }
    
    //Get number of reminders
    func getCount() -> Int {
        return reminders.count
    }
    
    //return  specific reminder
    func getReminder(index:Int)->Reminder{
        return reminders[index]
    }
    
    //Toggle completed status
    func  toggleCompleted(index: Int) {
        let reminder = getReminder(index: index)
        reminder.isCompleted = !reminder.isCompleted
    }
    
    //get reminder list
    func getReminders() -> [Reminder] {
        return reminders
    }
    
    //Delete a reminder
    func delete(index:Int){
        reminders.remove(at: index)
    }
    
    //get favourite
    func getFavoritedReminder() -> Reminder? {
        return reminders.first
    }
}
