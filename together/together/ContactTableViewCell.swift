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
    
    
    
    func setContact(_ contact: Contact, _ indexPath: Int) {
        nameLabel.text = contact.firstName + " " + contact.familyName
        
    }
    
    
    
}
