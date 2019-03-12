//
//  ImageCell.swift
//  WeChat
//
//  Created by Acan on 2019/3/12.
//  Copyright © 2019 weiphone. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    @IBOutlet weak var imageMessageView: UIImageView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var userMessage: UserMessage? {
        didSet {
            if let imageData = userMessage?.imageData, let image = UIImage(data: imageData) {
                let aspect = image.size.height / image.size.width
                imageMessageView.image = image
                heightConstraint.constant = aspect * 200
                layoutIfNeeded()
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageMessageView.layer.cornerRadius = 3.0
        imageMessageView.layer.masksToBounds = true
    }
}
