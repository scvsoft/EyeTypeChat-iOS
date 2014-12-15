//
//  EyeTypeChat.swift
//  EyeTypeChat
//
//  Created by Maria Ines Casadei on 12/11/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import Foundation
import CoreData

class Contact: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var phoneNumber: NSNumber
    @NSManaged var account: EyeTypeChat.Account // TODO: mark as unowned to avoid strong reference cycles

    class func createContact(name: String, phoneNumber: NSNumber, account: Account, entity: String, context: NSManagedObjectContext) -> Contact{
        
        var contact = NSEntityDescription.insertNewObjectForEntityForName(entity, inManagedObjectContext: context) as Contact
        contact.name = name
        contact.phoneNumber = phoneNumber
        contact.account = account
        
        return contact
    }
}
