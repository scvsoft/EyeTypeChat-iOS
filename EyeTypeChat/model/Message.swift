//
//  Message.swift
//  EyeTypeChat
//
//  Created by Maria Ines Casadei on 12/10/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import Foundation
import CoreData

class Message: NSManagedObject {

    @NSManaged var text: String
    @NSManaged var sentDateTime: NSDate
    @NSManaged var conversation: NSManagedObject
    @NSManaged var fromContact: Contact

}
