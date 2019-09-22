//
//  ProfileViewController.swift
//  together
//
//  Created by Helal Chowdhury on 9/21/19.
//  Copyright © 2019 Helal. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var eventTableView: UITableView!   
    
    var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTableView.delegate = self
        eventTableView.dataSource = self
        events = createArray()
        
    }
    
    func createArray() -> [Event] {
        let tempBool: [Event] = [Event.e1, Event.e2, Event.e3, Event.e4]
        print("1")
        return tempBool
        
    }
    
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = events[indexPath.row]
        print("10")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsCell") as! EventsViewCell
        print("100")
        
        cell.setEvents(event: event)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
   
}
