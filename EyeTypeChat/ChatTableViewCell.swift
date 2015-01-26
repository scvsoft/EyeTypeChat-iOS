//
//  ChatTableViewCell.swift
//  EyeTypeChat
//
//  Created by Maria Ines Casadei on 1/23/15.
//  Copyright (c) 2015 SCV Soft. All rights reserved.
//

import Foundation

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var fromLabel: UILabel!

    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var sentDateLabel: UILabel!
    
    func loadItem(from fromMessage: String, message: String, sentDate: NSDate, imageName: String) {
   
        fromLabel.text = fromMessage
        messageLabel.text = message
        sentDateLabel.text = MockedData.getFormattedDate(sentDate)
        photoView.image = UIImage(named: imageName)
    
    }
}