//
//  DriverViewController.swift
//  LyftClone
//
//  Created by nestoras neofytou on 22/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//

import UIKit
import MapKit

class DriverViewController: UIViewController, MKMapViewDelegate {
    
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
        /*
        let locations = LocationService.shared.getRecentLocations()
        pickupLocation = locations[0]
        dropoffLocation = locations[1]
        */
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
        
        
        //Add annotations
        mapView.delegate = self
        let driverAnnotation = VehicleAnnotation(coordinate: driver.coordinate)
        let pickupCoordinate = CLLocationCoordinate2D(latitude: pickupLocation!.lat, longitude: pickupLocation!.lng)
        let dropoffCoordinate = CLLocationCoordinate2D(latitude: dropoffLocation!.lat, longitude: dropoffLocation!.lng)
        let pickupAnnotation = LocationAnnotation(coordinate: pickupCoordinate, locationType: "pickup")
        let dropoffAnnotation = LocationAnnotation(coordinate: dropoffCoordinate, locationType: "dropoff")
        let annotations: [MKAnnotation] = [driverAnnotation, pickupAnnotation, dropoffAnnotation]
        mapView.addAnnotations(annotations)
        //zoom in diplaying all points
        mapView.showAnnotations(annotations, animated: false)
        
        //display route pt2
        let driverLocation = Location(title: driver.name, subtitle: driver.licensePlate, lat: driver.coordinate.latitude, lng: driver.coordinate.longitude)
        displayRoute(sourceLocation: driverLocation, destinationLocation: pickupLocation)
        
    }
    
    @IBAction func backButtonDidTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func editButtonDidTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func SafetyButtonDidTapped(_ sender: UIButton) {
    }
    @IBAction func contactButtonDidTapped(_ sender: UIButton) {
    }
    
    
    //use different images for annotations
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let reuseIdentifier = annotation is VehicleAnnotation ? "VehicleAnnotation": "LocationAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        } else {
            annotationView?.annotation = annotation
        }
        
        if annotation is VehicleAnnotation {
            annotationView?.image = UIImage(named: "car")
        } else if let locationAnnotation = annotation as? LocationAnnotation {
            annotationView?.image = UIImage(named: "dot-\(locationAnnotation.locationType)")
        }
        return annotationView
    }
    
    //display route
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5.0
        renderer.strokeColor = UIColor(red: 247.0/255.0, green: 66.0/255.0, blue: 190.0/255.0, alpha: 1.0)
        return renderer
    }
    
    //copy from RouteViewController
    func displayRoute(sourceLocation: Location, destinationLocation: Location) {
        let sourceCoordinate = CLLocationCoordinate2D(latitude: sourceLocation.lat, longitude: sourceLocation.lng)
        let destinationCoordinate = CLLocationCoordinate2D(latitude: destinationLocation.lat, longitude: destinationLocation.lng)
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationCoordinate)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            if let error = error{
                print("There is an error calculating the route \(error)")
                return
            }
            guard let response = response else {
                return
            }
            
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            
        }
    }
    
    
}
