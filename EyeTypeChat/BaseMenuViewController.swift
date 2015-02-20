//
//  BaseMenuViewController.swift
//  EyeTypeChat
//
//  Created by Emanuel Andrada on 4/12/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import UIKit

class BaseMenuViewController: UITableViewController, EyeControllable {

    /* class */ let CellIdentifier = "Cell"

    var showCancel = false

    var selectedIndexPath = NSIndexPath(forRow: 0, inSection: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        clearsSelectionOnViewWillAppear = false
        updateSelection()
    }

    func updateSelection() {
        tableView.selectRowAtIndexPath(selectedIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
    }

    func cell() -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as UITableViewCell?
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellIdentifier)
        }
        return cell!
    }
    
    func validRow(indexPath: NSIndexPath) -> NSIndexPath {
        if (indexPath.section >= numberOfSectionsInTableView(tableView)) {
            return NSIndexPath(forRow: 0, inSection: 0)
        }
        else if (indexPath.row >= tableView(tableView, numberOfRowsInSection: indexPath.section)) {
            return validRow(NSIndexPath(forRow: 0, inSection: indexPath.section + 1))
        }
        return indexPath
    }

    // MARK: EyeControllable

    func eyeDidAccept() {
        if self.respondsToSelector(Selector("tableView:didSelectRowAtIndexPath:")) {
            self.tableView(tableView, didSelectRowAtIndexPath: selectedIndexPath)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        NSLog("sarasa")
    }

    func eyeDidCancel() {
        navigationController?.popViewControllerAnimated(true)
    }

    func eyeChangeOption() {
        if let indexPath = selectedIndexPath {
            selectedIndexPath = validRow(NSIndexPath(forRow: indexPath.row + 1, inSection: indexPath.section))
        }
        updateSelection()
    }

    func setEyeCanCancel(canCancel: Bool) {
    }
}
