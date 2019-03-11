//
//  ChatCell.swift
//  WeChat
//
//  Created by weiphone on 2019/3/11.
//  Copyright © 2019 weiphone. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    
    enum ChatUser {
        case you
        case me
    }
    var type: ChatUser = .me
    
    var userMessage: UserMessage? {
        didSet {
            if userMessage?.name == "Acan" {
                type = .me
            } else {
                type = .you
            }
            
            messageLabel.text = userMessage?.text
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
