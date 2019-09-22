//
//  ContactsViewController.swift
//  together
//
//  Created by Helal Chowdhury on 9/21/19.
//  Copyright © 2019 Helal. All rights reserved.
//

import UIKit
import Contacts

class ContactsViewController: UIViewController {
    @IBOutlet weak var contactListTableView: UITableView!
    var contactList: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactList = createContactList()
        
        contactListTableView.delegate = self
        contactListTableView.dataSource = self
    }
    
    
    func createContactList() -> [Contact]{
        var tempContacts: [Contact] = []
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err {
                print("failed to req acess", err)
                return//this is completion handeling. prolly more bootstrap way of doing this too
            }
            if granted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do{
                    try store.enumerateContacts(with: request, usingBlock: {(contact, stopPointerIfYouWantStopEnumerating) in
                        let setContact = Contact(firstName: contact.givenName, familyName: contact.familyName)
//                        setContact.delegate = self
                        tempContacts.append(setContact)
                    })
                } catch let err{ print("enumeration fail", err) }
                
            }
            else { print("acess denied") }
        }
        return tempContacts
    }
}

extension ContactsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
//        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currCell = contactList[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCellID", for: indexPath) as? ContactTableViewCell else{
            print("cellforrowat dont work")
            fatalError()
        }
        cell.setContact(contact: currCell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //do this when tapped on cell
        
    }
    
}



