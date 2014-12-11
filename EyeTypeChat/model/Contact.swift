//
//  Contact.swift
//  EyeTypeChat
//
//  Created by Maria Ines Casadei on 12/10/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import Foundation
import CoreData

class Contact: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var phoneNumber: NSNumber
    @NSManaged var account: Account

}
