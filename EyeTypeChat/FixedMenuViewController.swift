//
//  FixedMenuViewController.swift
//  EyeTypeChat
//
//  Created by Emanuel Andrada on 9/12/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import UIKit

class FixedMenuViewController: BaseMenuViewController {

    @objc var menuName: String!

    var menuItems = [MenuItem]()

    override func viewDidLoad() {
        loadMenuItems()
        super.viewDidLoad()
    }

    func loadMenuItems() {
        if menuName == nil {
            NSException(name: NSInvalidArgumentException, reason: "Missing menuName", userInfo: nil).raise()
        }
        else {
            let file = NSBundle.mainBundle().pathForResource("fixedMenus", ofType: "plist")!
            let allMenus = NSDictionary(contentsOfFile: file)!
            let menu = allMenus[menuName] as NSArray!
            for item in menu {
                menuItems.append(MenuItem(dictionary: item as Dictionary<String, String>))
            }
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return showCancel ? 2 : 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section > 0 {
            return 1
        }
        return menuItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.cell()
        if indexPath.section > 0 {
            cell.textLabel?.text = "Cancel"
        }
        else {
            cell.textLabel?.text = menuItems[indexPath.row].title
        }
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section > 0 {
            eyeDidCancel()
        }
        else {
            performSelectorInObject(self, menuItems[indexPath.row].selector)
        }
    }

    class MenuItem {
        var title: String
        var selector: Selector

        init (dictionary: Dictionary<String, String>) {
            title = dictionary["title"]!
            selector = Selector(dictionary["selector"]!)
        }
    }
}
