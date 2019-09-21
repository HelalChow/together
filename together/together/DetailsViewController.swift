//
//  DetailsViewController.swift
//  together
//
//  Created by Helal Chowdhury on 9/21/19.
//  Copyright © 2019 Helal. All rights reserved.
//

import UIKit
import EventKit
import MapKit

class DetailsViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var jobDetailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        label.text = title
        
        // Do any additional setup after loading the view.
    }
    
    func getLocation() -> CLLocationCoordinate2D {
        let home = CLLocationCoordinate2D(latitude: 40.6742, longitude: -73.8419)
        let map = MapViewController()
        
        guard var coordinate = map.currentCoordinate else { return home}
        return coordinate
        
    }
    
    
    let map = MapViewController()
    
    
    @IBAction func registerClicked(_ sender: Any) {
        let eventStore:EKEventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event) {(granted, error) in
            if (granted) && (error) == nil
            {
                print("granted \(granted)")
                print("error \(error)")
                
                let event:EKEvent = EKEvent(eventStore: eventStore)
                event.title = "Hurricane Dorian Clothing Drive"
                event.startDate = Date()
                event.endDate = Date()
                event.notes = ""
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let error as NSError{
                    print("error : \(error)")
                }
                print("Save Event")
            } else{
                print("error : \(error)")
            }
            
        }
    }
    
}
