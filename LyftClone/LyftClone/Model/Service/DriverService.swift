//
//  DriverService.swift
//  LyftClone
//
//  Created by nestoras neofytou on 22/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//

import Foundation

class DriverService{
    static let shared = DriverService()
    
    private init(){}
    
    func getDriver(pickupLocation: Location) -> (Driver, Int){
        let driver = Driver(name: "Alicia Castillo", thumbnail: "driver", licensePlate: "7WB312S", rating: 5.0, car: "Hunday Sonata")
        return(driver, 10)
    }
    
}
