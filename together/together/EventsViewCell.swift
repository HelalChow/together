//
//  EventsViewCell.swift
//  together
//
//  Created by Helal Chowdhury on 9/21/19.
//  Copyright © 2019 Helal. All rights reserved.
//

import UIKit

class EventsViewCell: UITableViewCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    func setEvents(event: Event) {
        eventImageView.image = event.image
        dateLabel.text = event.date
        dayLabel.text = event.day
    }
    
}
