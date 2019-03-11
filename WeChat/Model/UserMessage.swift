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
    var database: Database = Database(withPath: "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!) + /userMessage.db")
    
    var identifier: Int?
    var message: String?
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = UserMessage
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case identifier
        case message
    }
    
    init() {
        do {
            try database.create(table: "userMessageTable", of: UserMessage.self)
        } catch  {
            print("创建失败")
        }
    }
    
    func insertMessage(_ userMessage: UserMessage) {
        do {
            try database.insert(objects: userMessage, intoTable: "userMessageTable")
        } catch {
            print("插入失败")
        }
    }
    
    func deleteMessage(_ userMessage: UserMessage) {
        do {
            try database.delete(fromTable: "userMessageTable", where: UserMessage.Properties.identifier == userMessage.identifier!)
        } catch {
            print("删除失败")
        }
    }
    
    func updateMessage(_ userMessage: UserMessage) {
        
    }
    
    func findMessage(_ userMessage: UserMessage) {

    }
}
