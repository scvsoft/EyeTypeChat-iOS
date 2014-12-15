//
//  ViewController.swift
//  EyeTypeChat
//
//  Created by Emanuel Andrada on 6/11/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: ETVideoSourceViewController {

    var timer: NSTimer?
    var subNavigationController: UINavigationController!
    var conversationNavigationController: UINavigationController!
    var ignoreNextTick = false

    var myModel: MainViewModel {
        get {
            return self.model as MainViewModel
        }
    }

    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            return managedObjectContext
        }
        else {
            return nil
        }
    }()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.model = MainViewModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createMockedData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        startDetect()
        startTimer()
    }

    func startTimer() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(self.myModel.tickInterval, target: self, selector: Selector("tick"), userInfo: nil, repeats: true)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        stopDetect()
        self.timer = nil
    }

    func startDetect() {
        self.videoSource.startRunning()
    }

    func stopDetect() {
        self.videoSource.stopRunning()
    }

    func createMockedData(){
        
        // create Telegram account
        var telegramAccount = TelegramAccount.createTelegramAccount("XYZ123", entity: "TelegramAccount", context: self.managedObjectContext!)
        
        // create contact list
        var firstContact = Contact.createContact("Mary", phoneNumber: 263823827, account: telegramAccount, entity: "Contact", context:  self.managedObjectContext!)
        var secondContact = Contact.createContact("Anna", phoneNumber: 1161690000, account: telegramAccount, entity: "Contact", context:  self.managedObjectContext!)
        var thirdContact = Contact.createContact("John", phoneNumber: 328378738, account: telegramAccount, entity: "Contact", context:  self.managedObjectContext!)
        var contactSet = NSMutableSet()
        contactSet.addObjectsFromArray([firstContact, secondContact, thirdContact])
        
        //asociate contact list with the Telegram account
        telegramAccount.contacts = contactSet
        
        println(managedObjectContext!)
        printMockedData()
        
    }
    
    func printMockedData(){
        let fetchRequest = NSFetchRequest(entityName: "TelegramAccount")
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [TelegramAccount] {
            let contacts = fetchResults[0].contacts
            for contact in contacts! {
                if let eachContact = contact as? Contact {
                    println("Contact Name: \(eachContact.name). Phone Number: \(eachContact.phoneNumber)")
                }
            }
            
//            let conversations = fetchResults[0].conversations
//            for chat in conversations! {
//                if let eachChat = chat as? Conversation {
//                    println("Chat: \(eachChat.title)")
//                    for text in eachChat.messages{
//                        println("\(text)")
//                        
//                    }
//                }
//            }
        }
        
        
    }
    
    @IBAction func eyeDidAccept() {
        if let controllable = subNavigationController.topViewController as? EyeControllable {
            controllable.eyeDidAccept()
        }
        ignoreNextTick = true
    }

    @IBAction func eyeDidCancel() {
        if let controllable = subNavigationController.topViewController as? EyeControllable {
            controllable.eyeDidCancel()
        }
        ignoreNextTick = true
    }

    func tick() {
        if !ignoreNextTick {
            if let controllable = subNavigationController.topViewController as? EyeControllable {
                controllable.eyeChangeOption()
            }
        }
        else {
            ignoreNextTick = false
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "subNavigationController") {
            subNavigationController = segue.destinationViewController as UINavigationController
        }
        else if (segue.identifier == "conversation") {
            conversationNavigationController = segue.destinationViewController as UINavigationController
        }
    }

    override var mainViewController: MainViewController? {
        get {
            return self
        }
    }

}
