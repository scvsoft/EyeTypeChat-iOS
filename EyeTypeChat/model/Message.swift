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
    @NSManaged var conversation: EyeTypeChat.Conversation // TODO: mark as unowned to avoid strong reference cycles
    @NSManaged var fromContact: EyeTypeChat.Contact? // fromContact is nil when the message was sent by the user himself

    class func createMessage(text: String, sentDateTime: NSDate, conversation: Conversation, fromContact: Contact?, entity: String, context: NSManagedObjectContext) -> Message{
      
        var message = NSEntityDescription.insertNewObjectForEntityForName(entity, inManagedObjectContext: context) as Message
        message.text = text
        message.sentDateTime = sentDateTime
        message.conversation = conversation
        message.fromContact = fromContact;
        
        return message
    }
    
}
