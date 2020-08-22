//
//  LocationAnnotation.swift
//  LyftClone
//
//  Created by nestoras neofytou on 22/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//

import Foundation
import MapKit

class LocationAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    let locationType: String
    
    init(coordinate: CLLocationCoordinate2D, locationType: String){
        self.coordinate = coordinate
        self.locationType = locationType
    }
}
