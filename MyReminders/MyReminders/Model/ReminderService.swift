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
    
    private var url: URL
    
    private init(){
        url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        url.appendPathComponent("reminder.json")
        load()
    }
    
    //saveData
    func save(){
        do{
        let encoder = JSONEncoder()
        let data = try encoder.encode(reminders)
        try data.write(to: url)
        } catch{
            print("error saving file \(error.localizedDescription)")
        }
    }
    //LoadData
    func load(){
        do{
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        reminders = try decoder.decode([Reminder].self, from: data)
        } catch {
            print("error loading data file \(error.localizedDescription)")
        }
    }
    
    
    
    //Create
    func create(reminder: Reminder){
        var indexToInsert: Int?
        for (i, element) in reminders.enumerated(){
            if element.date.timeIntervalSince1970 > reminder.date.timeIntervalSince1970{
                indexToInsert = i
                break
            }
        }
        if let indexToInsert = indexToInsert {
            reminders.insert(reminder, at: indexToInsert)
        } else {
            reminders.append(reminder)
        }
        
        save()
    }
    
    //Update
    func update(reminder: Reminder, index: Int){
        reminders[index] = reminder
        save()
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
        save()
    }
    
    //get reminder list
    func getReminders() -> [Reminder] {
        return reminders
    }
    
    //Delete a reminder
    func delete(index:Int){
        reminders.remove(at: index)
        save()
    }
    
    //get favourite
    func getFavoritedReminder() -> Reminder? {
        return reminders.first
    }
}
