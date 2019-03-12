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
    @IBOutlet weak var iconView: UIImageView!
    
    var aspect: CGFloat = 0
    var userMessage: UserMessage? {
        didSet {
            if let imageData = userMessage?.imageData, let image = UIImage(data: imageData) {
                aspect = image.size.height / image.size.width
                imageMessageView.image = image
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

    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize = CGSize(width: 200, height: 200 * aspect)
        imageMessageView.frame = CGRect(x: iconView.frame.minX - imageSize.width - 10, y: iconView.frame.minY, width: imageSize.width, height: imageSize.height)
    }
}
