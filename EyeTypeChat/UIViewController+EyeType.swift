//
//  UIViewController+EyeType.swift
//  EyeTypeChat
//
//  Created by Emanuel Andrada on 4/12/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import UIKit

extension UIViewController {
    var mainViewController: MainViewController? {
        get {
            return parentViewController?.mainViewController as MainViewController?
        }
    }
}
