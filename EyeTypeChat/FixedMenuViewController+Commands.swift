//
//  ConversationViewController+Commands.swift
//  EyeTypeChat
//
//  Created by Emanuel Andrada on 9/12/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import Foundation

extension ConversationViewController {

    func showKeyboard() {
        let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("keyboard") as UIViewController!
        self.navigationController!.pushViewController(viewController, animated: true)
    }
}
