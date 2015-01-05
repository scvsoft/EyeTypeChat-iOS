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
    
    var conversationItems = [Conversation]()
    
    override func viewDidLoad() {
        loadConversationItems()
        super.viewDidLoad()
    }
    
    func loadConversationItems() {
        // load dynamically the mocked conversations
        conversationItems = MockedData.getConversationList(managedObjectContext!)
        
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
            self.mainViewController?.selectConversation(conversationItems[indexPath.row])
            let vc = storyboard!.instantiateViewControllerWithIdentifier("fixedMenu") as FixedMenuViewController
            vc.menuName = "conversation"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    

}
