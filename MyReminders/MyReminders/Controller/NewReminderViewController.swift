//
//  NewReminderViewController.swift
//  MyReminders
//
//  Created by nestoras neofytou on 12/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//

import UIKit

class NewReminderViewController: UIViewController{
    
    var reminderIndex: Int? //index reminder passed when editing
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var completedSwitch: UISwitch!
    @IBOutlet weak var savebutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savebutton.layer.cornerRadius=25.0
        
        //check if editing
        if let reminderIndex = reminderIndex{
            let reminder = ReminderService.share.getReminder(index: reminderIndex)
        //update info
            titleTextField.text = reminder.title
            datePicker.date = reminder.date
            completedSwitch.isOn = reminder.isCompleted
            
        }
    }
    
    
    @IBAction func saveButtonDidTapped(_ sender: UIButton) {
        //create reminder object
        let reminder=Reminder(title: titleTextField.text!, date: datePicker.date, isCompleted: completedSwitch.isOn)
        
        
        
        
        //check if editing
        if let reminderIndex = reminderIndex{
            ReminderService.share.update(reminder: reminder, index: reminderIndex)
            
        } else     //create a reminder
            {ReminderService.share.create(reminder: reminder)}
          
        //popView
        navigationController!.popViewController(animated: true)
            
    }

//Dissmis the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
