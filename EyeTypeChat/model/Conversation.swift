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
    @NSManaged var account: EyeTypeChat.Account // TODO: mark as unowned to avoid strong reference cycles
    @NSManaged var betweenContacts: NSSet
    @NSManaged var messages: NSSet?

    class func createConversation(title: String?, account: Account, betweenContacts: NSSet, messages: NSSet?, entity: String, context: NSManagedObjectContext) -> Conversation{
        
        var defaultTitle = ""
        if title == nil{
            defaultTitle = createDefaultTitleConversationBetweenContacts(betweenContacts)
        }
        var conversation = NSEntityDescription.insertNewObjectForEntityForName(entity, inManagedObjectContext: context) as Conversation
        conversation.title = title != nil ? title! : defaultTitle
        conversation.account = account
        conversation.betweenContacts = betweenContacts;
        conversation.messages = messages;
        
        return conversation
    }
    
    class func createDefaultTitleConversationBetweenContacts(betweenContacts: NSSet) -> NSString{
        var title = "Chat with "
        for var i = 0; i<betweenContacts.count; ++i{
            title += (betweenContacts.allObjects[i] as Contact).name
            if(i<betweenContacts.count-2){
                title += (", ")
            }
            else if(i==betweenContacts.count-2){
                title += (" and ")
            }
        }
        return title
    }
}