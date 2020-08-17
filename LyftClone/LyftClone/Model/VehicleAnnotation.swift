//
//  VehicleAnnotation.swift
//  LyftClone
//
//  Created by nestoras neofytou on 17/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//

import MapKit

class VehicleAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    init(coordinate: CLLocationCoordinate2D){
        self.coordinate = coordinate
    }
}
