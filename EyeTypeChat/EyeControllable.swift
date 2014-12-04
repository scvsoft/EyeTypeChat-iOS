//
//  EyeControllable.swift
//  EyeTypeChat
//
//  Created by Emanuel Andrada on 3/12/14.
//  Copyright (c) 2014 SCV Soft. All rights reserved.
//

import Foundation

@objc
protocol EyeControllable {

    func eyeDidAccept()
    func eyeDidCancel()

    func eyeChangeOption()

    func setEyeCanCancel(canCancel: Bool)

}
