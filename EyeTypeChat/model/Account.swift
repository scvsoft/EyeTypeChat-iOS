//
//  EyeTypeChat.swift
//  EyeTypeChat
//
//  Created by Maria Ines Casadei on 12/11/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import Foundation
import CoreData

class Account: NSManagedObject {

    @NSManaged var userIdentifier: String
    @NSManaged var contacts: NSSet?
    @NSManaged var conversations: NSSet?

}
