//
//  Event.swift
//  together
//
//  Created by Helal Chowdhury on 9/21/19.
//  Copyright © 2019 Helal. All rights reserved.
//

import Foundation
import UIKit

class Event {
    var image: UIImage
    var date: String
    var day: String
    
    init(image: UIImage, date: String, day: String) {
        self.image = image
        self.date = date
        self.day = day
    }
}

//dummy varaibles
extension Event {
    static let e1 = Event(image: UIImage(named: "Hurricane") ?? UIImage(), date: "8", day: "Sat")
    static let e2 = Event(image: UIImage(named: "Food") ?? UIImage(), date: "11", day: "Tue")
    static let e3 = Event(image: UIImage(named: "911") ?? UIImage(), date: "9", day: "Sun")
    static let e4 = Event(image: UIImage(named: "Park") ?? UIImage(), date: "12", day: "Sat")
}
