//
//  MockedData.swift
//  EyeTypeChat
//
//  Created by Maria Ines Casadei on 12/18/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class MockedData {
    
    class func createMockedData(dataContext: NSManagedObjectContext){
        
        // create Telegram account
        var telegramAccount = TelegramAccount.createTelegramAccount("XYZ123", entity: "TelegramAccount", context: dataContext)
        
        // create contact list
        var firstContact = Contact.createContact("Mary", phoneNumber: 263823827, account: telegramAccount, entity: "Contact", context:  dataContext)
        var secondContact = Contact.createContact("Anna", phoneNumber: 1161690000, account: telegramAccount, entity: "Contact", context: dataContext)
        var thirdContact = Contact.createContact("John", phoneNumber: 328378738, account: telegramAccount, entity: "Contact", context: dataContext)
        var contactSet = NSMutableSet()
        contactSet.addObjectsFromArray([firstContact, secondContact, thirdContact])
        
        // create conversation
        var contactsInBffChat = NSMutableSet()
        contactsInBffChat.addObject(firstContact)
        var bffConversation = Conversation.createConversation("BBF", account: telegramAccount, betweenContacts: contactsInBffChat, messages: nil, entity: "Conversation", context: dataContext)
        
        // create some messages for bff conversation
        var currentDate: NSDate? = NSDate();
        var msg1 = Message.createMessage("Hi Mary!", sentDateTime: currentDate!, conversation: bffConversation, fromContact: nil, entity: "Message", context: dataContext)
        
        var msg2 = Message.createMessage("How are you?", sentDateTime: currentDate!, conversation: bffConversation, fromContact: nil, entity: "Message", context: dataContext)
        
        currentDate = MockedData.dateByAddingMinutes(1, date: currentDate)
        var msg3 = Message.createMessage("Great! and u?", sentDateTime: currentDate!, conversation: bffConversation, fromContact: firstContact, entity: "Message", context: dataContext)
        
        currentDate = MockedData.dateByAddingMinutes(2, date: currentDate)
        var msg4 = Message.createMessage("How was San Francisco?", sentDateTime: currentDate!, conversation: bffConversation, fromContact: firstContact, entity: "Message", context: dataContext)

        currentDate = MockedData.dateByAddingMinutes(1, date: currentDate)
        var msg5 = Message.createMessage("Fantastic! See u tomorrow?", sentDateTime: currentDate!, conversation: bffConversation, fromContact: nil, entity: "Message", context:dataContext)
        
        currentDate = MockedData.dateByAddingMinutes(3, date: currentDate)
        var msg6 = Message.createMessage("Sure :)", sentDateTime: currentDate!, conversation: bffConversation, fromContact: firstContact, entity: "Message", context: dataContext)
        
        var messages = NSMutableSet()
        messages.addObjectsFromArray([msg1, msg2, msg3, msg4, msg5, msg6])
        bffConversation.messages = messages
        var conversationSet = NSMutableSet()
        conversationSet.addObject(bffConversation)
        
        //associate contact list with the Telegram account
        telegramAccount.contacts = contactSet
        //associate conversation list with the Telegram account
        telegramAccount.conversations = conversationSet
        

    }
   
    class func dateByAddingMinutes(value: Int, date: NSDate?) -> NSDate?{
        return NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.CalendarUnitMinute, value: value, toDate: date!, options: NSCalendarOptions.SearchBackwards)
    }
    
    class func printMockedData(dataContext: NSManagedObjectContext){
        
        println(dataContext)
        let fetchRequest = NSFetchRequest(entityName: "TelegramAccount")
        if let fetchResults = dataContext.executeFetchRequest(fetchRequest, error: nil) as? [TelegramAccount] {
            
            let contacts = fetchResults[0].contacts
            for contact in contacts! {
                if let eachContact = contact as? Contact {
                    println("Contact Name: \(eachContact.name). Phone Number: \(eachContact.phoneNumber)")
                }
            }
            
            let conversations = fetchResults[0].conversations
            for chat in conversations! {
                if let eachChat = chat as? Conversation {
                    println("Chat: \(eachChat.title)")
                    let messages = eachChat.messages
                    var msgsArray = messages?.allObjects as [Message]
                    
                    var sortedMsgs : [Message] = msgsArray
                    sortedMsgs.sort({$0.sentDateTime.timeIntervalSinceNow < $1.sentDateTime.timeIntervalSinceNow})
                    
                    for msg in sortedMsgs{
                        println("Message: \(msg.text) Sent:  \(msg.sentDateTime)")
                    }
                    
                }
            }
            
        }
        
    }
    
   
    
}