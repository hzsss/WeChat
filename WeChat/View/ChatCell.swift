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
    
    @IBOutlet weak var bgView: UIView!
    
    var userMessage: UserMessage? {
        didSet {
            messageLabel.text = userMessage?.text
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.layer.cornerRadius = 3.0
        bgView.layer.masksToBounds = true
    }
    
}
