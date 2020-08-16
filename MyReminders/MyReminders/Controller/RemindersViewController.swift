//
//  RemindersViewController.swift
//  MyReminders
//
//  Created by nestoras neofytou on 12/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//

import UIKit

class RemindersViewController : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    //Refresh the view every time the user visits it
    @IBOutlet weak var tableview: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableview.reloadData()
    }
    
    //togle completed view color
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ReminderService.share.toggleCompleted(index: indexPath.row)
        tableview.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReminderService.share.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Deque the cell from the reuse pool
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell") as! ReminderCell
        
        
        //Get the reminder for the given index path
        let reminder = ReminderService.share.getReminder(index: indexPath.row)
        
        //Update the cell based on the reminder object
        cell.update(reminder: reminder, index: indexPath.row)
        
        //Return cell
        return cell
    }
    
    
    //set up the edit button
    @IBAction func editButtonDidPressed(_ sender: UIBarButtonItem) {
        if tableview.isEditing{
            tableview.isEditing=false
            sender.title = "Edit"
        } else{
            tableview.isEditing = true
            sender.title = "Done"
        }
    }
    
    //Delete cell functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            //1.delete reminder
            ReminderService.share.delete(index: indexPath.row)
            //2.delete cell
            tableview.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //pass info between 2 view controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //conditions:
        //1.Identify th segue
        //2.verify destination
        //3.verify the pressed button
        if segue.identifier == "UpdateSegue", let NewReminderViewController = segue.destination as? NewReminderViewController, let infoButton = sender as? UIButton {
            NewReminderViewController.reminderIndex = infoButton.tag
        }
        
        
        
        
    }
    
}
