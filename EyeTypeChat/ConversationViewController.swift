//
//  ConversationViewController.swift
//  EyeTypeChat
//
//  Created by Emanuel Andrada on 4/12/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ConversationViewController: BaseMenuViewController {
    
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            return managedObjectContext
        }
        else {
            return nil
        }
        }()
    
    var conversationItems = [ConversationItem]()
    
    override func viewDidLoad() {
        loadConversationItems()
        super.viewDidLoad()
    }
    
    func loadConversationItems() {
        // load dynamically the mocked conversations
        let conversations = MockedData.getConversationList(managedObjectContext!)
        for item in conversations! {
            let chatItem = ConversationItem(item: item as Conversation)
            conversationItems.append(chatItem)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return showCancel ? 2 : 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section > 0 {
            return 1
        }
        return conversationItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.cell()
        if indexPath.section > 0 {
            cell.textLabel?.text = "Cancel"
        }
        else {
            cell.textLabel?.text = conversationItems[indexPath.row].title
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section > 0 {
            eyeDidCancel()
        }
        else {
            performSelectorInObject(self, conversationItems[indexPath.row].selectorForKeyboard, conversationItems[indexPath.row].conversation)
        }
    }
    
    class ConversationItem {
        var title: String
        var selectorForKeyboard: Selector
        var conversation: Conversation
        
        init (item: Conversation) {
            title = item.title
            selectorForKeyboard = Selector("showKeyboardForConversation:")
            conversation = item
        }
    }
    
}
