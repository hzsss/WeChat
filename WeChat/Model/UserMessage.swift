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
    var database: Database = Database(withPath: "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!)/userMessage.db")
    
    var identifier: Int?
    var name: String?
    var text: String?
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = UserMessage
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case identifier
        case name
        case text
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                identifier: ColumnConstraintBinding(isPrimary: true)
            ]
        }
    }
    
    var isAutoIncrement: Bool = true
    var lastInsertedRowID: Int64 = 0
    
    init(name: String?, text: String?) {
        self.name = name
        self.text = text
        
        do {
            try database.create(table: "userMessage", of: UserMessage.self)
        } catch  {
            print("创建失败")
        }
    }
    
    func insertMessage(_ userMessage: UserMessage) {
        do {
            try database.insert(objects: userMessage, intoTable: "userMessage")
        } catch {
            print("插入失败")
        }
    }
    
    func deleteMessage(_ userMessage: UserMessage) {
        do {
            try database.delete(fromTable: "userMessage", where: UserMessage.Properties.identifier == userMessage.identifier!)
        } catch {
            print("删除失败")
        }
    }
    
    func updateMessage(_ userMessage: UserMessage) {
        
    }
    
    func findMessage(_ userMessage: UserMessage) {

    }
}
