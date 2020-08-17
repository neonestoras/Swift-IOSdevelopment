//
//  HomeViewController.swift
//  LyftClone
//
//  Created by nestoras neofytou on 17/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class HomeViewController : UIViewController, UITableViewDataSource, CLLocationManagerDelegate, MKMapViewDelegate{
    
    var locations = [Location]()
    @IBOutlet weak var searchButton: UIButton!
    
    var locationManager: CLLocationManager!
    var currentUserLocation: Location!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set location
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
        
        
        //Add Shaow around button
        searchButton.layer.cornerRadius = 10.0
        searchButton.layer.shadowRadius = 1.0
        searchButton.layer.shadowColor = UIColor.black.cgColor
        searchButton.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        searchButton.layer.shadowOpacity = 0.5
        
        //preview 2 recent locations
        let recentLocations = LocationService.shared.getRecentLocations()
        locations = [recentLocations[0], recentLocations[1]]
        
    }

    ///////////////////////////////////////////
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let firstLocation = locations.first!
        currentUserLocation = Location(title: "Current Location", subtitle: "", lat: firstLocation.coordinate.latitude, lng: firstLocation.coordinate.longitude)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            locationManager.startUpdatingLocation()
        }
    }
    ////////////////////////////////////////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") as! LocationCell
        let location = locations[indexPath.row]
        cell.update(location: location)
        return cell
    }
    ///////////////////////////////////////////
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //zoom in in user colation
        let distance = 200.0
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: distance, longitudinalMeters: distance)
        mapView.setRegion(region, animated: true)
        
        //create 3 vehicle anotations and add them to mapview
        ////////for demostration
        let lat = userLocation.coordinate.latitude
        let lng = userLocation.coordinate.longitude
        let offset = 0.00075
        let coord1 = CLLocationCoordinate2D(latitude: lat + offset, longitude: lng - offset)
        let coord2 = CLLocationCoordinate2D(latitude: lat - offset, longitude: lng)
        let coord3 = CLLocationCoordinate2D(latitude: lat - offset, longitude: lng + offset)

        ///////
        mapView.addAnnotations([
            VehicleAnnotation(coordinate: coord1),
            VehicleAnnotation(coordinate: coord2),
            VehicleAnnotation(coordinate: coord3)
        ])
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        //create custom annotation with cars
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "VehicleAnnotation")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "VehicleAnnotation")
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "car")
        annotationView?.transform = CGAffineTransform(rotationAngle: CGFloat(arc4random_uniform(360)*180) / CGFloat.pi)
        
        return annotationView
        
    }
    
    
}
