//
//  ViewController.swift
//  EyeTypeChat
//
//  Created by Emanuel Andrada on 6/11/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: ETVideoSourceViewController , ChatControllable {

    var timer: NSTimer?
    var subNavigationController: UINavigationController!
    var chatNavigationController: UINavigationController!
    var ignoreNextTick = false
    
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
        createAndPrintMockedData()
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

    
    var myModel: MainViewModel {
        get {
            return self.model as MainViewModel
        }
    }
    
    func createAndPrintMockedData(){
        var mockedData = MockedData(dataContext: managedObjectContext!)
        //  MockedData.printMockedData(managedObjectContext!)
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

    func selectConversation(chat: Conversation){
        let c = self.chatNavigationController.topViewController as ChatViewController
        c.loadConversation(chat)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "subNavigationController") {
            subNavigationController = segue.destinationViewController as UINavigationController
        }
        else if (segue.identifier == "chatSegue") {
            chatNavigationController = segue.destinationViewController as UINavigationController
        }
    }

    override var mainViewController: MainViewController? {
        get {
            return self
        }
    }
    
    // MARK: ChatControllable
    
    func chatWillType(letter: String) {
        let c = self.chatNavigationController.topViewController as ChatViewController
        c.type(letter)
    }
    
    func chatWillSend() {
        let c = self.chatNavigationController.topViewController as ChatViewController
        c.sendMessage()
    }
    
    func chatWillClearAll() {
        let c = self.chatNavigationController.topViewController as ChatViewController
        c.clearCurrentText()
    }

}
