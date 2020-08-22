//
//  Driver.swift
//  LyftClone
//
//  Created by nestoras neofytou on 22/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//

import Foundation

class Driver {
    let name: String
    let thumbnail: String
    let licensePlate: String
    let rating: Float
    let car:String
    
    init(name: String, thumbnail: String, licensePlate: String, rating: Float, car:String){
        self.name = name
        self.thumbnail = thumbnail
        self.licensePlate = licensePlate
        self.rating = rating
        self.car = car
    }
    
}
