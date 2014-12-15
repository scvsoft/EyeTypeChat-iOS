//
//  EyeTypeChat.swift
//  EyeTypeChat
//
//  Created by Maria Ines Casadei on 12/11/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import Foundation
import CoreData

class Conversation: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var account: EyeTypeChat.Account
    @NSManaged var betweenContacts: NSSet
    @NSManaged var messages: NSSet

}
