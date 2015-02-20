//
//  EyeTypeChat.swift
//  EyeTypeChat
//
//  Created by Maria Ines Casadei on 1/28/15.
//  Copyright (c) 2015 SCV Soft. All rights reserved.
//

import Foundation
import CoreData

class Contact: NSManagedObject {

    @NSManaged dynamic var color: UIColor
    @NSManaged var name: String
    @NSManaged var phoneNumber: NSNumber
    @NSManaged var account: EyeTypeChat.Account // TODO: mark as unowned to avoid strong reference cycles
    
    
    class func createContact(name: String, phoneNumber: NSNumber, color: UIColor, account: Account, entity: String, context: NSManagedObjectContext) -> Contact{
        
        var contact = NSEntityDescription.insertNewObjectForEntityForName(entity, inManagedObjectContext: context) as Contact
        contact.name = name
        contact.phoneNumber = phoneNumber
        contact.account = account
        contact.color = color
        
        return contact
        
    }


}
