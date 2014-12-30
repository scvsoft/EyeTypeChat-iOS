//
//  ChatViewController.swift
//  EyeTypeChat
//
//  Created by Maria Ines Casadei on 12/30/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ChatViewController: BaseMenuViewController {
    
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            return managedObjectContext
        }
        else {
            return nil
        }
        }()
    
    var selectedConversation: Conversation?
    
    lazy var chatModel: ChatViewModel = ChatViewModel(currentConversation: self.selectedConversation!)
    
    var messageItems = [MessageItem]()
    
    
    override func viewDidLoad() {
        
        let conversationList: NSSet? = MockedData.getConversationList(managedObjectContext!)
        var chatItem: Conversation? = nil
        for item in conversationList! {
            chatItem = item as? Conversation
            break
        }
        self.selectedConversation = chatItem
        self.navigationItem.title = chatItem?.title
        loadMessagesItems(forChat: self.selectedConversation!)
        super.viewDidLoad()
    }
    
    func loadMessagesItems(forChat chat: Conversation) {
        // load dynamically the mocked conversations
        let messages = MockedData.getMessages(managedObjectContext!, forConversation: chat)
        for item in messages! {
            let chatItem = MessageItem(item: item as Message)
            messageItems.append(chatItem)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section > 0 {
            return 1
        }
        return messageItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.chatCell()
        var messageFrom:String
        if let from = messageItems[indexPath.row].message.fromContact{
            messageFrom = "\(from.name)"
        }else{
            messageFrom = "\(MockedData.getUserIdentifier(managedObjectContext!)!)"
        }

        cell.textLabel?.text = messageFrom + ": " + messageItems[indexPath.row].message.text
        cell.detailTextLabel?.text = MockedData.getFormattedDate(messageItems[indexPath.row].message.sentDateTime)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Do nothing
    }
    
    class MessageItem {
        
        var message: Message
        
        init (item: Message) {
            message = item
        }
    }
    
}
