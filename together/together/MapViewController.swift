//
//  MapViewController.swift
//  together
//
//  Created by Helal Chowdhury on 9/21/19.
//  Copyright © 2019 Helal. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FlyoverKit
import Speech


class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        mapView.delegate = self
        userLocationSetup()
        self.mapSetup()
        
        
    }
    
    func mapSetup() {
        self.mapView.mapType = .hybridFlyover
        self.mapView.showsBuildings = true
        self.mapView.isZoomEnabled = true
        self.mapView.isScrollEnabled = true
        
        let camera = FlyoverCamera(mapView: self.mapView, configuration: FlyoverCamera.Configuration(duration: 6.0, altitude: 60000, pitch: 45.0, headingStep: 40.0))
        camera.start(flyover: FlyoverAwesomePlace.newYork)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10), execute:{
            camera.stop()
        })
    }
    
    func userLocationSetup(){
        locationManager.requestAlwaysAuthorization() //we can ask this later
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 100
        mapView.showsUserLocation = true
        mapView.mapType = MKMapType.hybrid
    }
    
    func zoomIn(_ coordinate: CLLocationCoordinate2D){
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(zoomRegion, animated: true)
    }
    
    func addAnnotations(){
        let timesSqaureAnnotation = MKPointAnnotation()
        timesSqaureAnnotation.title = "9/11 Day of Service"
        timesSqaureAnnotation.coordinate = CLLocationCoordinate2D(latitude: 40.758896, longitude: -73.9855)
        
        let empireStateAnnotation = MKPointAnnotation()
        empireStateAnnotation.title = "Hurricane Dorian Clothing Drive"
        empireStateAnnotation.coordinate = CLLocationCoordinate2D(latitude: 40.7484, longitude: -73.9857)
        
        let brooklynBridge = MKPointAnnotation()
        brooklynBridge.title = "Food Pantry Delivery"
        brooklynBridge.coordinate = CLLocationCoordinate2D(latitude: 40.7061, longitude: -73.9969)
        
        let prospectPark = MKPointAnnotation()
        prospectPark.title = "Feed The Homeless Soup Kitchen"
        prospectPark.coordinate = CLLocationCoordinate2D(latitude: 40.6602, longitude: -73.9690)
        
        let jersey = MKPointAnnotation()
        jersey.title = "It's My Park"
        jersey.coordinate = CLLocationCoordinate2D(latitude: 40.7178, longitude: -74.0431)
        
        mapView.addAnnotation(timesSqaureAnnotation)
        mapView.addAnnotation(empireStateAnnotation)
        mapView.addAnnotation(brooklynBridge)
        mapView.addAnnotation(prospectPark)
        mapView.addAnnotation(jersey)
    }
    
    func showRoute() {
        let sourceLocation = currentCoordinate ?? CLLocationCoordinate2D(latitude: 40.6742, longitude: -73.8418)
        let destinationLocation = CLLocationCoordinate2D(latitude: 40.7484, longitude: -73.9857)
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate {(response, error) in
            guard let directionResponse = response else {
                if let error = error{
                    print("There was an error getting directions==\(error.localizedDescription)")
                }
                return
            }
            let route = directionResponse.routes[0]
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
        
        self.mapView.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer{
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        else{
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            
            pin.canShowCallout = true
            pin.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            return pin
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        showRoute()
        let annView = view.annotation
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {
            print("detals vc not founds")
            return
        }
        
        
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.mapView.showsUserLocation = true
        guard let latestLocation = locations.first else { return }
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: latestLocation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        if currentCoordinate == nil{
            zoomIn(latestLocation.coordinate)
            addAnnotations()
        }
        
        currentCoordinate = latestLocation.coordinate
        
    }
}

