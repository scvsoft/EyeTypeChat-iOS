//
//  ChatViewModel.swift
//  EyeTypeChat
//
//  Created by Maria Ines Casadei on 12/29/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import Foundation

class ChatViewModel {

    var currentConversation: Conversation
    var currentWritingText: String
    
    init(currentConversation conversation: Conversation){
        self.currentConversation = conversation
        self.currentWritingText = ""
    }
    
    func clearWrittenText(){
        currentWritingText = ""
    }
    
    
}