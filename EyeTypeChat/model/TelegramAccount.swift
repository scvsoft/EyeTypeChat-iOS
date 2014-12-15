//
//  EyeTypeChat.swift
//  EyeTypeChat
//
//  Created by Maria Ines Casadei on 12/11/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import Foundation
import CoreData

class TelegramAccount: EyeTypeChat.Account {

    class func createTelegramAccount(userIdentifier: String, entity: String, context: NSManagedObjectContext) -> TelegramAccount{
    
        var telegramAccount = NSEntityDescription.insertNewObjectForEntityForName(entity, inManagedObjectContext: context) as TelegramAccount
        telegramAccount.userIdentifier = userIdentifier
       
        return telegramAccount
    }
    
   
    
}
