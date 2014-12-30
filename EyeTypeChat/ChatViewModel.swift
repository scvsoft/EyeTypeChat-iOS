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
    var currentMessageStatus: MessageStatus
    var currentWritingText: String {
        get {
            return self.currentWritingText
        }
        set(text) {
            if(self.currentMessageStatus==MessageStatus.InProgress){
                return
            }
            if(text.isEmpty){
                self.currentMessageStatus = MessageStatus.Empty
            }
            else{
               self.currentMessageStatus = MessageStatus.Ok
            }
            self.currentWritingText = text
        }
    }
    
    init(currentConversation conversation: Conversation){
        self.currentConversation = conversation
        self.currentMessageStatus = MessageStatus.Empty
        self.currentWritingText = ""
    }
    
    func clearWrittenText(){
        currentWritingText = ""
    }
    
    enum MessageStatus {
        case Empty, Ok, InProgress, Created
    }
    
}