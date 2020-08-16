//
//  Location.swift
//  LyftClone
//
//  Created by nestoras neofytou on 16/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//

import Foundation

class Location : Codable{
    
    var title: String
    var subtitle: String
    let lat: Double
    let lng: Double
    
    //Constructor
    init(title: String, subtitle: String, lat: Double, lng: Double) {
        self.title = title
        self.subtitle = subtitle
        self.lat = lat
        self.lng = lng
    }
    
    
}
