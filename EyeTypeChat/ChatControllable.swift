//
//  ChatControllable.swift
//  EyeTypeChat
//
//  Created by Maria Ines Casadei on 1/2/15.
//  Copyright (c) 2015 SCV Soft. All rights reserved.
//

import Foundation

@objc
protocol ChatControllable {
    
    func chatDidType()
    func chatDidSend()

}