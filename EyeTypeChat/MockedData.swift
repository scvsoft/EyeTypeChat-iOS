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
    
    init(dataContext: NSManagedObjectContext){
        
        // create Telegram account
        var telegramAccount = TelegramAccount.createTelegramAccount("Me", entity: "TelegramAccount", context: dataContext)
        
        // create contact list
        var contactSet = NSMutableSet()
        var firstContact = Contact.createContact("Mary", phoneNumber: 263823827, color: MockedData.randomColor(), account: telegramAccount, entity: "Contact", context:  dataContext)
        var secondContact = Contact.createContact("Anna", phoneNumber: 1161690000, color: MockedData.randomColor(), account: telegramAccount, entity: "Contact", context: dataContext)
        var thirdContact = Contact.createContact("John", phoneNumber: 328378738, color: MockedData.randomColor(), account: telegramAccount, entity: "Contact", context: dataContext)
        contactSet.addObjectsFromArray([firstContact, secondContact, thirdContact])
        
        // create conversations
        var conversationSet = NSMutableSet()
        
        // create bff chat
        var contactsInBffChat = NSMutableSet()
        contactsInBffChat.addObject(firstContact)
        var bffConversation = Conversation.createConversation(nil, account: telegramAccount, betweenContacts: contactsInBffChat, messages: nil, entity: "Conversation", context: dataContext)
        
        // create some messages for bff chat
        var currentDate: NSDate? = NSDate();
        let yesterdayDate: NSDate? = NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitDay, value: -1, toDate: NSDate(), options: nil)
        var msg01 = Message.createMessage("Hi Mary!", sentDateTime: yesterdayDate!, conversation: bffConversation, fromContact: nil, entity: "Message", context: dataContext)
        
        currentDate = MockedData.dateByAddingMinutes(-30, date: currentDate)
        var msg02 = Message.createMessage("How are you?", sentDateTime: currentDate!, conversation: bffConversation, fromContact: nil, entity: "Message", context: dataContext)
        
        currentDate = MockedData.dateByAddingMinutes(2, date: currentDate)
        var msg03 = Message.createMessage("Great! and u?", sentDateTime: currentDate!, conversation: bffConversation, fromContact: firstContact, entity: "Message", context: dataContext)
        
        currentDate = MockedData.dateByAddingMinutes(1, date: currentDate)
        var msg04 = Message.createMessage("How was San Francisco?", sentDateTime: currentDate!, conversation: bffConversation, fromContact: firstContact, entity: "Message", context: dataContext)

        currentDate = MockedData.dateByAddingMinutes(1, date: currentDate)
        var msg05 = Message.createMessage("Fantastic! See u tomorrow?", sentDateTime: currentDate!, conversation: bffConversation, fromContact: nil, entity: "Message", context:dataContext)
        
        currentDate = MockedData.dateByAddingMinutes(2, date: currentDate)
        var msg06 = Message.createMessage("Sure :)", sentDateTime: currentDate!, conversation: bffConversation, fromContact: firstContact, entity: "Message", context: dataContext)
        
        var messages = NSMutableSet()
        messages.addObjectsFromArray([msg01, msg02, msg03, msg04, msg05, msg06])
        bffConversation.messages = messages
        conversationSet.addObject(bffConversation)
        
        // create group chat
        var contactsInGroupChat = NSMutableSet()
        contactsInGroupChat.addObjectsFromArray([secondContact, thirdContact])
        var groupConversation = Conversation.createConversation(nil, account: telegramAccount, betweenContacts: contactsInGroupChat, messages: nil, entity: "Conversation", context: dataContext)
        
        // create some messages for group chat
        currentDate = MockedData.dateByAddingMinutes(-50, date: NSDate())
        var msg11 = Message.createMessage("Hello everyone!", sentDateTime: currentDate!, conversation: groupConversation, fromContact: secondContact, entity: "Message", context: dataContext)
        
        currentDate = MockedData.dateByAddingMinutes(1, date: currentDate)
        var msg12 = Message.createMessage("Hi!", sentDateTime: currentDate!, conversation: groupConversation, fromContact: nil, entity: "Message", context: dataContext)
        
        currentDate = MockedData.dateByAddingMinutes(0, date: currentDate)
        var msg13 = Message.createMessage("Any news from Tom?", sentDateTime: currentDate!, conversation: groupConversation, fromContact: secondContact, entity: "Message", context: dataContext)
        
        currentDate = MockedData.dateByAddingMinutes(2, date: currentDate)
        var msg14 = Message.createMessage("He sent a confirmation email, testing test testi n g a e i o ups hey !! 628ndnjshuy ash sjue ttt ehsshs xbxbxb sggsye yquwwb ja.", sentDateTime: currentDate!, conversation: groupConversation, fromContact: thirdContact, entity: "Message", context: dataContext)
        
        currentDate = MockedData.dateByAddingMinutes(1, date: currentDate)
        var msg15 = Message.createMessage("The plane arrives to NY at 10pm", sentDateTime: currentDate!, conversation: groupConversation, fromContact: nil, entity: "Message", context:dataContext)
        
        currentDate = MockedData.dateByAddingMinutes(1, date: currentDate)
        var msg16 = Message.createMessage("Perfect", sentDateTime: currentDate!, conversation: groupConversation, fromContact: secondContact, entity: "Message", context: dataContext)
        
        var groupMessages = NSMutableSet()
        groupMessages.addObjectsFromArray([msg11, msg12, msg13, msg14, msg15, msg16])
        groupConversation.messages = groupMessages
        conversationSet.addObject(groupConversation)
        
        // create multiple group chat
        var contactsInMultipleGroupChat = NSMutableSet()
        contactsInMultipleGroupChat.addObjectsFromArray([firstContact, secondContact, thirdContact])
        var multipleGroupConversation = Conversation.createConversation(nil, account: telegramAccount, betweenContacts: contactsInMultipleGroupChat, messages: nil, entity: "Conversation", context: dataContext)
        
        // create some messages for multiple group chat
        currentDate = MockedData.dateByAddingMinutes(-50, date: NSDate())
        var msg17 = Message.createMessage("1, 2, 3", sentDateTime: currentDate!, conversation: multipleGroupConversation, fromContact: secondContact, entity: "Message", context: dataContext)
        
        currentDate = MockedData.dateByAddingMinutes(1, date: currentDate)
        var msg18 = Message.createMessage("4", sentDateTime: currentDate!, conversation: multipleGroupConversation, fromContact: firstContact, entity: "Message", context: dataContext)
        
        currentDate = MockedData.dateByAddingMinutes(0, date: currentDate)
        var msg19 = Message.createMessage("5", sentDateTime: currentDate!, conversation: multipleGroupConversation, fromContact: secondContact, entity: "Message", context: dataContext)
        
        currentDate = MockedData.dateByAddingMinutes(2, date: currentDate)
        var msg20 = Message.createMessage("6, 7, 7, 7", sentDateTime: currentDate!, conversation: multipleGroupConversation, fromContact: thirdContact, entity: "Message", context: dataContext)
        
        currentDate = MockedData.dateByAddingMinutes(1, date: currentDate)
        var msg21 = Message.createMessage("blah blah 8", sentDateTime: currentDate!, conversation: multipleGroupConversation, fromContact: nil, entity: "Message", context:dataContext)
        
        currentDate = MockedData.dateByAddingMinutes(1, date: currentDate)
        var msg22 = Message.createMessage("9Blah! ", sentDateTime: currentDate!, conversation: multipleGroupConversation, fromContact: secondContact, entity: "Message", context: dataContext)
        
        var multipleGroupMessages = NSMutableSet()
        multipleGroupMessages.addObjectsFromArray([msg17, msg18, msg19, msg20, msg21, msg22])
        multipleGroupConversation.messages = multipleGroupMessages
        conversationSet.addObject(multipleGroupConversation)
        
        // associate contact list with the Telegram account
        telegramAccount.contacts = contactSet
        // associate conversation list with the Telegram account
        telegramAccount.conversations = conversationSet
        
    }
    
    class func getUserIdentifier(dataContext: NSManagedObjectContext) -> String?{
        let fetchRequest = NSFetchRequest(entityName: "TelegramAccount")
        if let fetchResults = dataContext.executeFetchRequest(fetchRequest, error: nil) as? [TelegramAccount] {
            
            return fetchResults[0].userIdentifier
        }
        return nil
    }
    
    class func dateByAddingMinutes(value: Int, date: NSDate?) -> NSDate?{
        return NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.CalendarUnitMinute, value: value, toDate: date!, options: NSCalendarOptions.SearchBackwards)
    }
    
    class func getConversationList(dataContext: NSManagedObjectContext) -> NSOrderedSet{
        let fetchRequest = NSFetchRequest(entityName: "Conversation")
        var orderedConversation = NSMutableOrderedSet()
        if let fetchResults = dataContext.executeFetchRequest(fetchRequest, error: nil) as? [Conversation]
        {
            var lastMessageInConversations = NSMutableOrderedSet()
            for conversation in fetchResults{
                if let lastMessage = MockedData.getLastMessage(dataContext, forConversation: conversation){
                    lastMessageInConversations.addObject(lastMessage)
                }
            }
            
            let sortDateDescriptor = NSSortDescriptor(key: "sentDateTime", ascending: false)
            lastMessageInConversations.sortUsingDescriptors([sortDateDescriptor])
            lastMessageInConversations.enumerateObjectsUsingBlock { (elem, idx, stop) -> Void in
                let sms = elem as Message
                let chat = sms.conversation as Conversation
                orderedConversation.addObject(chat)
            }
        }

       return orderedConversation
    }
    
    
    class func getLastMessage(dataContext: NSManagedObjectContext, forConversation chat: Conversation?) -> Message?{
       let orderedMsgs = MockedData.getOrderedMessages(dataContext, forConversation: chat)
       return orderedMsgs?.lastObject as Message?
       
    }
    
    class func getOrderedMessages(dataContext: NSManagedObjectContext, forConversation chat: Conversation?) -> NSArray?{
        let fetchRequest = NSFetchRequest(entityName: "Message")
        var chatText = chat!.title
        let chatPredicate = NSPredicate(format: "SELF.conversation.title = %@", chatText)
        fetchRequest.predicate = chatPredicate
        var dateDescriptor = NSSortDescriptor(key: "sentDateTime", ascending: true)
        fetchRequest.sortDescriptors = [dateDescriptor]
        return dataContext.executeFetchRequest(fetchRequest, error: nil) as? [Message]
    }

    class func addNewMessage(dataContext: NSManagedObjectContext, message: String, conversation: Conversation){
        var currentDate: NSDate? = NSDate();
        var msg = Message.createMessage(message, sentDateTime: currentDate!, conversation: conversation, fromContact: nil, entity: "Message", context: dataContext)
    }
    
    class func printMockedData(dataContext: NSManagedObjectContext){
        
        let fetchRequest = NSFetchRequest(entityName: "TelegramAccount")
        if let fetchResults = dataContext.executeFetchRequest(fetchRequest, error: nil) as? [TelegramAccount] {
            
            let contacts = fetchResults[0].contacts
            println("Contact list")
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
                        let sentFormattedDate = MockedData.getFormattedDate(msg.sentDateTime)
                        var messageDetails: String
                        if let from = msg.fromContact{
                           messageDetails = "Message: \(msg.text). From: \(msg.fromContact!.name). Sent:  \(sentFormattedDate)."
                        }else{
                            messageDetails = "Message: \(msg.text). From: \(MockedData.getUserIdentifier(dataContext)!) Sent:  \(sentFormattedDate)."
                        }
                      
                        println(messageDetails)
                    }
                    
                }
            }
            
        }
        
    }
    
    class func getFormattedDate(dateTime: NSDate)-> String{
        let dateStringFormatter = NSDateFormatter()
        if MockedData.isSameDay(dateTime, thanDate: NSDate()){
            dateStringFormatter.dateFormat = "hh:mm"
        }
        else{
            dateStringFormatter.dateFormat = "MM-dd-yyyy hh:mm"
        }
        return dateStringFormatter.stringFromDate(dateTime)
    }
   
    class func isSameDay(dateTime: NSDate, thanDate anotherDate: NSDate)-> Bool {
        let calendar = NSCalendar.currentCalendar()
        let unitFlags: NSCalendarUnit = .YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit
        let componentDateTime = calendar.components(unitFlags, fromDate: dateTime)
        let componentToday = calendar.components(unitFlags, fromDate: anotherDate)
        let day = componentDateTime.day == componentToday.day
        let month = componentDateTime.month == componentToday.month
        let year = componentDateTime.year == componentToday.year
        return (day && month && year)
    }
    
    /*
    Distributed under The MIT License:
    http://opensource.org/licenses/mit-license.php
    
    Permission is hereby granted, free of charge, to any person obtaining
    a copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:
    
    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
    LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
    OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
    WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    */
    class func randomColor() -> UIColor{
        // from https://gist.github.com/kylefox/1689973
        
        let value1 = UInt32(128)
        let value2 : Float32 = 256.0
        let value3 : Float32 = 0.5
        
        let hueRandom = Float(arc4random() % 256)
        let hueValue =  hueRandom / 256.0 //  0.0 to 1.0
        let hue = CGFloat(hueValue)
        print(hueValue)
        
        let saturationRandom = arc4random() % value1
        let saturationValue = Float(saturationRandom) / value2 + value3 //  0.5 to 1.0, away from white
        let saturation = CGFloat(saturationValue)
        print(saturationValue)
        
        let brightnessRandom = arc4random() % value1
        let brightnessValue = Float(brightnessRandom) / value2 + value3 //  0.5 to 1.0, away from black
        let brightness = CGFloat(brightnessValue)
        print(brightnessValue)
        
        let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
        return color
    }
    
}