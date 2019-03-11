//
//  TalkCell.swift
//  WeChat
//
//  Created by weiphone on 2019/3/11.
//  Copyright © 2019 weiphone. All rights reserved.
//

import UIKit

class TalkCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    
    var userMessage: UserMessage? {
        didSet {
            messageLabel.text = userMessage?.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
