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
    
    @IBOutlet weak var writingTextField: UITextField!
    
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
        loadConversations()
        super.viewDidLoad()
    }
    
    func loadConversations(){
        let conversationList = MockedData.getConversationList(managedObjectContext!)
        loadConversation(conversationList[0] as Conversation)
    }
    
    func loadConversation(chat: Conversation){
        self.selectedConversation = chat
        self.navigationItem.title = chat.title
        loadMessagesItems(forChat: self.selectedConversation!)
    }
    
    func loadMessagesItems(forChat chat: Conversation) {
        messageItems.removeAll(keepCapacity: true)
        chatModel = ChatViewModel(currentConversation: chat)
        writingTextField.text = chatModel.currentWritingText
        self.selectedConversation = chatModel.currentConversation
        // load dynamically the mocked conversations
        let messages = MockedData.getOrderedMessages(managedObjectContext!, forConversation: chat)
        for item in messages! {
            let chatItem = MessageItem(item: item as Message)
            messageItems.append(chatItem)
        }
        tableView.reloadData()
        goToBottom()
    }
    
    func addNewMessage(){
        MockedData.addNewMessage(managedObjectContext!, message: self.writingTextField.text, conversation: self.chatModel.currentConversation)
    }
    
    class MessageItem {
        
        var message: Message
        
        init (item: Message) {
            message = item
        }
    }
    
    // MARK: UITableViewController
    
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
        
        var cell:ChatTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("chatCell") as ChatTableViewCell
        
        //configuring cell
        cell.textLabel?.lineBreakMode = .ByWordWrapping
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .None
        cell.userInteractionEnabled = false
        
        //getting values for cell
        let messageText = messageItems[indexPath.row].message.text
        let messageSentDate = messageItems[indexPath.row].message.sentDateTime
        var messageFrom:String
        var contactColor:UIColor
        if let from = messageItems[indexPath.row].message.fromContact{
            messageFrom = "\(from.name)"
            contactColor = from.color
        }else{
            messageFrom = "\(MockedData.getUserIdentifier(managedObjectContext!)!)"
            contactColor = UIColor.blueColor() // default color for user: blue
        }

        let userDefaultImage = "user_default.png"
                
        //loading cell
        cell.loadItem(from: messageFrom, fromContactColor: contactColor, message: messageText, sentDate: messageSentDate, imageName: userDefaultImage)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Do nothing
    }
    
    
    // MARK: Chat
    
    func type(letter: String) {
        chatModel.currentWritingText = chatModel.currentWritingText + letter
        writingTextField.text = chatModel.currentWritingText
    }
    
    func sendMessage() {
        addNewMessage()
        loadConversations()
        clearCurrentText()
    }
    
    func clearCurrentText(){
        chatModel.currentWritingText = ""
        writingTextField.text = chatModel.currentWritingText
    }
    
    func goToBottom(){
        tableView.scrollToRowAtIndexPath(lastIndexPath(), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
    }
    
    func lastIndexPath() -> NSIndexPath{
        let lastRowIndex = tableView.numberOfRowsInSection(0) - 1
        print(lastRowIndex)
        return NSIndexPath(forRow: lastRowIndex, inSection: 0)
    }
    
    
}
