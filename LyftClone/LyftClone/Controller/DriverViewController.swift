//
//  DriverViewController.swift
//  LyftClone
//
//  Created by nestoras neofytou on 22/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//

import UIKit
import MapKit

class DriverViewController: UIViewController {
    
    var pickupLocation: Location!
    var dropoffLocation: Location!
    
    @IBOutlet weak var etaLabel: UILabel!
    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var carLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var licensePlateLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var driverImageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        licensePlateLabel.layer.cornerRadius = 15.0
        licensePlateLabel.layer.borderColor = UIColor.gray.cgColor
        licensePlateLabel.layer.borderWidth = 1.0
        driverImageView.layer.cornerRadius = driverImageView.frame.size.width / 2.0
        backButton.layer.cornerRadius = backButton.frame.size.width / 2.0
        
        //for demostration purposes
        let locations = LocationService.shared.getRecentLocations()
        pickupLocation = locations[0]
        dropoffLocation = locations[1]
        ///////////
        
        
        let (driver, eta) = DriverService.shared.getDriver(pickupLocation: pickupLocation)
        
        etaLabel.text = "Arrives in \(eta) min"
        driverNameLabel.text = driver.name
        carLabel.text = driver.car
        let ratingString = String(format:"%.1f", driver.rating)
        ratingImageView.image = UIImage(named: "rating-\(ratingString)")
        ratingLabel.text = ratingString
        licensePlateLabel.text = driver.licensePlate
        driverImageView.image = UIImage(named: driver.thumbnail)
    }
    
    
}
