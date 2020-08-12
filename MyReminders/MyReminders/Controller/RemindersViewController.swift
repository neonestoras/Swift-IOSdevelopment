//
//  RemindersViewController.swift
//  MyReminders
//
//  Created by nestoras neofytou on 12/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//

import UIKit

class RemindersViewController : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReminderService.share.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
