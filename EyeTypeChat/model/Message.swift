//
//  EyeTypeChat.swift
//  EyeTypeChat
//
//  Created by Maria Ines Casadei on 12/11/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import Foundation
import CoreData

class Message: NSManagedObject {

    @NSManaged var sentDateTime: NSDate
    @NSManaged var text: String
    @NSManaged var conversation: EyeTypeChat.Conversation
    @NSManaged var fromContact: EyeTypeChat.Contact

}
