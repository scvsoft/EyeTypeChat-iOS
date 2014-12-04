//
//  ViewController.swift
//  EyeTypeChat
//
//  Created by Emanuel Andrada on 6/11/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import UIKit

class MainViewController: ETVideoSourceViewController {

    var timer: NSTimer?
    var subNavigationController: UINavigationController!
    var ignoreNextTick = false

    var myModel: MainViewModel {
        get {
            return self.model as MainViewModel
        }
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.model = MainViewModel()
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
    }

}
