//
//  LocationViewController.swift
//  LyftClone
//
//  Created by nestoras neofytou on 19/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController : UIViewController, UITableViewDataSource, UITextFieldDelegate,MKLocalSearchCompleterDelegate {
    
    var locations = [Location]()
    var pickupLocation: Location?
    var dropoffLocation: Location?
    @IBOutlet weak var dropoffTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    var searchCompleater = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locations = LocationService.shared.getRecentLocations()
        
        dropoffTextField.becomeFirstResponder()
        dropoffTextField.delegate = self
        searchCompleater.delegate = self
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let latestString = (textField.text as! NSString).replacingCharacters(in: range, with: string)
        
        if latestString.count > 3 {
            searchCompleater.queryFragment = latestString
        }
        
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.isEmpty ? locations.count : searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") as! LocationCell
        
        if searchResults.isEmpty {
            let location = locations[indexPath.row]
            cell.update(location: location)
        } else{
            cell.update(searchResault: searchResults[indexPath.row])
        }
        return cell
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        //reload table view
        tableView.reloadData()
    }
    
}
