//
//  LocationCell.swift
//  LyftClone
//
//  Created by nestoras neofytou on 17/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//

import UIKit
import MapKit

class LocationCell : UITableViewCell {
    
    @IBOutlet weak var adressLine1: UILabel!

    @IBOutlet weak var adressLine2: UILabel!
    
    func update(location: Location){
        adressLine1.text = location.title
        adressLine2.text = location.subtitle
    }
    
    func update(searchResault: MKLocalSearchCompletion){
        adressLine1.text = searchResault.title
        adressLine2.text = searchResault.subtitle
        
    }
    
}
