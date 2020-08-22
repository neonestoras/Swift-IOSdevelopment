//
//  RouteViewController.swift
//  LyftClone
//
//  Created by nestoras neofytou on 22/08/2020.
//  Copyright © 2020 NestorasNeofytou. All rights reserved.
//

import UIKit
import MapKit

class RouteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var routeLabelContainerView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var selectRideButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var pickupLocation: Location!
    var dropoffLocation: Location!
    var rideQuotes = [RideQuote]()
    var selectedIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routeLabelContainerView.layer.cornerRadius = 10.0
        backButton.layer.cornerRadius = backButton.frame.size.width / 2.0
        selectRideButton.layer.cornerRadius = 10.0
        
        /*
        //populate for testig
        let locations = LocationService.shared.getRecentLocations()
        pickupLocation = locations[0]
        dropoffLocation = locations[1]
        */
        
        rideQuotes = RideQuoteService.shared.getQuotes(pickupLocation: pickupLocation!, dropoffLocation: dropoffLocation!)
        
        //add route to map pickup-dropoff route
        let pickupCoordinate = CLLocationCoordinate2D(latitude: pickupLocation!.lat, longitude: pickupLocation!.lng)
        let dropoffCoordinate = CLLocationCoordinate2D(latitude: dropoffLocation!.lat, longitude: dropoffLocation!.lng)
        //create annotation
        let pickupAnnotation =  LocationAnnotation(coordinate: pickupCoordinate, locationType: "pickup")
        let dropoffAnnotation = LocationAnnotation(coordinate: dropoffCoordinate, locationType: "dropoff")
        mapView.addAnnotations([pickupAnnotation, dropoffAnnotation])
        
        //set custom identifiers
        mapView.delegate = self
        
        //route display
        
        displayRoute(sourceLocation: pickupLocation!, destinationLocation: dropoffLocation!)
        
    }
    //hide navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func backButtonDidPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
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
            
            let EDGE_INSET: CGFloat = 80.0
            let boundingMapRect = route.polyline.boundingMapRect
            self.mapView.setVisibleMapRect(boundingMapRect, edgePadding: UIEdgeInsets(top: EDGE_INSET, left: EDGE_INSET, bottom: EDGE_INSET, right: EDGE_INSET), animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rideQuotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RideQuoteCell") as! RideQuoteCell
               cell.update(rideQuote: rideQuotes[indexPath.row])
                
        //border update
        cell.updateSelectStatus(status: indexPath.row == selectedIndex)
        
               return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        let selectedRideQuote = rideQuotes[selectedIndex]
        selectRideButton.setTitle("Select \(selectedRideQuote.name)", for: .normal)
        tableView.reloadData()
        
    }
    
    //display route
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5.0
        renderer.strokeColor = UIColor(red: 247.0/255.0, green: 66.0/255.0, blue: 190.0/255.0, alpha: 1.0)
        return renderer
    }
    
    
    //to set up custom annotations
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        let reuseIdentifier = "LocationAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        } else {
            annotationView!.annotation = annotation
        }
        
        let locationAnnotation = annotation as! LocationAnnotation
        annotationView?.image = UIImage(named: "dot-\(locationAnnotation.locationType)")
        return annotationView
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let driverViewController = segue.description as? DriverViewController{
            driverViewController.pickupLocation = pickupLocation
            driverViewController.dropoffLocation = dropoffLocation
        }
    }
}
