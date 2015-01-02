//
//  ConversationViewController+Commands.swift
//  EyeTypeChat
//
//  Created by Emanuel Andrada on 9/12/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import Foundation

extension ConversationViewController {

    func showKeyboardForConversation(conversation: Conversation) {
        let viewController: KeyboardViewController = self.storyboard!.instantiateViewControllerWithIdentifier("keyboard") as KeyboardViewController!
        viewController.selectedConversation = conversation
        self.navigationController!.pushViewController(viewController, animated: true)
    }

}
