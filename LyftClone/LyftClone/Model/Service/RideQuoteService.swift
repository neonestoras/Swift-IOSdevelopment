//
//  RideQuoteService.swift
//  LyftClone
//
//  Created by nestoras neofytou on 16/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//

import Foundation
import CoreLocation

class RideQuoteService {
    
    static let shared = RideQuoteService()
    
    private init(){}
    
    func getQuotes(pickupLocation: Location, dropoffLocation: Location) -> [RideQuote] {
        //calculate the distance between locations
        let location1 = CLLocation(latitude: pickupLocation.lat, longitude: pickupLocation.lng)
        let location2 = CLLocation(latitude: dropoffLocation.lat, longitude: dropoffLocation.lng)
        
        let distance = location1.distance(from: location2) //CLL  is always in meters
        let minAmount = 3.0 // min ride fare
        
        //for demostration the rides are hardcoded - fixed in the code
        return [
            RideQuote(thumbnail: "ride-shared", name: "Shared", capacity: "1-2", price: minAmount + distance * 0.5, time: Date()),
            RideQuote(thumbnail: "ride-compact", name: "Shared", capacity: "4", price: minAmount + distance * 0.9, time: Date()),
            RideQuote(thumbnail: "ride-large", name: "Shared", capacity: "6", price: minAmount + distance * 1.35, time: Date())
        ]
    }
}
