//
//  RideQuote.swift
//  LyftClone
//
//  Created by nestoras neofytou on 16/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//


//Data Presented when selecting a ride
import Foundation

class RideQuote{
    
    let thumbnail: String
    let name: String
    let capacity: String
    let price: Double
    let time: Date
    
    init(thumbnail: String, name: String, capacity: String, price: Double, time: Date) {
        self.thumbnail = thumbnail
        self.name = name
        self.capacity = capacity
        self.price = price
        self.time = time
    }
    
}
