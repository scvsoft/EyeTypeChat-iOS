//
//  KeyboardViewController.swift
//  EyeTypeChat
//
//  Created by Emanuel Andrada on 3/12/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import UIKit

class KeyboardViewController: UIViewController, EyeControllable {

    @IBOutlet var keyboardContainer: UIView!
    @IBOutlet var cancelButton: UIButton!
    var chatControllable:ChatControllable! = nil
    var keyButtons = [[UIButton]]()
    var selectedButton: UIButton?
    let margin: CGFloat = 8

    var keys = [
        ["a", "b", "c", "d", "1", "2"],
        ["e", "f", "g", "h", "3", "4"],
        ["i", "j", "k", "l", "m", "n"],
        ["o", "p", "q", "r", "s", "t"],
        ["u", "v", "w", "x", "y", "z"],
        ["5", "6", "7", "8", "9", "0"],
        ["space", "comma", "point", "clear", "send"]
    ]
    var showCancel = false
    var currentLine = 0
    var currentRow = 0
    var lineSelected = false

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createKeyboard()
    }

    
    func createKeyboard() {
        self.keyboardContainer.removeConstraints(self.keyboardContainer.constraints())
        var i = 0
        var prevLine: UIView? = nil
        for line in self.keys {
            var j = 0
            var prevRow: UIView? = nil
            self.keyButtons.append([UIButton]())
            for key in line {
                var button = UIButton.buttonWithType(UIButtonType.System) as UIButton
                button.backgroundColor = UIColor.redColor()
                button.setTitle(key, forState: UIControlState.Normal)
                button.setTranslatesAutoresizingMaskIntoConstraints(false)
                self.keyButtons[i].append(button)
                self.keyboardContainer.addSubview(button)
                if let neighbor = prevLine {
                    self.keyboardContainer.addConstraint(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: neighbor, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: margin))
                }
                else {
                    self.keyboardContainer.addConstraint(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.keyboardContainer, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
                }
                if let neighbor = prevRow {
                    self.keyboardContainer.addConstraint(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: neighbor, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: margin))
                    self.keyboardContainer.addConstraint(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: neighbor, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0))
                    self.keyboardContainer.addConstraint(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: neighbor, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0))
                }
                else {
                    self.keyboardContainer.addConstraint(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.keyboardContainer, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
                }
                prevRow = button
                NSLog("%@", button)
                j++
            }
            self.keyboardContainer.addConstraint(NSLayoutConstraint(item: self.keyboardContainer, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: prevRow!, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
            prevLine = keyButtons[i][0]
            i++
        }
        self.keyboardContainer.addConstraint(NSLayoutConstraint(item: self.keyboardContainer, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: prevLine!, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        currentLine = 0
        currentRow = 0
        updateSelection()
    }

    func updateSelection() {
        selectedButton?.selected = false
        if currentLine < keys.count && currentRow < keys[currentLine].count {
            selectedButton = keyButtons[currentLine][currentRow]
        }
        else {
            selectedButton = cancelButton
        }
        selectedButton!.selected = true
    }
    
    func updateWritingText(letter:String) {
        chatControllable.chatWillType(letter)
    }

    func sendWrittenText() {
        chatControllable.chatWillSend()
    }
    
    func clearWrittenText() {
        chatControllable.chatWillClearAll()
    }
    
    func executeActionAccordingToKeySelection(key: String){
        switch key{
            case "send":
                sendWrittenText()
            case "clear":
                clearWrittenText()
            case "point":
                updateWritingText(".")
            case "comma":
                updateWritingText(",")
            case "space":
                updateWritingText(" ")
            default:
                updateWritingText(key)
            
        }
    }
// MARK: EyeControllable

    func eyeDidAccept() {
        if (lineSelected) {
            if (selectedButton == cancelButton) {
                eyeDidCancel()
            }
            else {
                let keySelection = selectedButton!.titleForState(UIControlState.Normal)!
                NSLog("key '%@'", keySelection)
                currentLine = 0
                currentRow = 0
                lineSelected = false
                updateSelection()
                executeActionAccordingToKeySelection(keySelection)
            }
        }
        else {
            lineSelected = true
        }
    }

    @IBAction func eyeDidCancel() {
        if (lineSelected) {
            currentRow = 0
            lineSelected = false
            updateSelection()
        }
        else {
            navigationController?.popViewControllerAnimated(true)
        }
    }

    func eyeChangeOption() {
        if lineSelected {
            let rows = keys[currentLine].count + (showCancel ? 1 : 0)
            currentRow++
            currentRow %= rows
        }
        else {
            let lines = keys.count + (showCancel ? 1 : 0)
            currentLine++
            currentLine %= lines
        }
        updateSelection()
    }

    func setEyeCanCancel(canCancel: Bool) {
        self.showCancel = !canCancel
    }

}
