//
//  ContactTableViewCell.swift
//  together
//
//  Created by Helal Chowdhury on 9/21/19.
//  Copyright © 2019 Helal. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var pointsLabel: UILabel!
    
//    var images : UIImage = UIImage(named:"img-1")!
    let images = ["profile", "profile copy", "profile copy 2", "profile copy 3"]
    let points = ["328", "251", "86", "93", "107", "65"]
    
    func setContact(_ contact: Contact, _ indexPath: Int) {
        nameLabel.text = contact.firstName + " " + contact.familyName
        profileView.image = UIImage(named: images[indexPath%4])
        pointsLabel.text = points[indexPath%6]
        
    }
    
    
    
}
