//
//  UserMessage.swift
//  WeChat
//
//  Created by weiphone on 2019/3/8.
//  Copyright © 2019 weiphone. All rights reserved.
//

import UIKit
import WCDBSwift

class UserMessage: TableCodable {
    var identifier: Int?
    var message: String?
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = UserMessage
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case identifier
        case message
    }
    
    init() {
        
    }
}
