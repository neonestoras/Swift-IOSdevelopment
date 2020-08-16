//
//  LocationService.swift
//  LyftClone
//
//  Created by nestoras neofytou on 16/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//

import Foundation

class LocationService{
    
    static let shared = LocationService()
    
    private var recentLocations = [Location]()
    
    private init(){
        //populate with saved locations from json file in Supporting Files
        let locationsUrl = Bundle.main.url(forResource: "Locations", withExtension: "json")!
        let data = try! Data(contentsOf: locationsUrl)
        let decoder = JSONDecoder()
        recentLocations = try! decoder.decode([Location].self, from: data)
    }
    
    func getRecentLocations() -> [Location] {
        return recentLocations
    }
    
}
