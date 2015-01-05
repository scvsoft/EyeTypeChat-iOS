//
//  ConversationViewController+Commands.swift
//  EyeTypeChat
//
//  Created by Emanuel Andrada on 9/12/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import Foundation

extension BaseMenuViewController {

    func showKeyboard() {
        let viewController: KeyboardViewController = self.storyboard!.instantiateViewControllerWithIdentifier("keyboard") as KeyboardViewController!
        viewController.chatControllable = mainViewController?
        self.navigationController!.pushViewController(viewController, animated: true)
    }

}
