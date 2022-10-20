//
//  TweetDetaModel.swift
//  TwitterSample
//
//  Created by 小坂部泰成 on 2022/10/18.
//

import Foundation
import RealmSwift

class TweetDetaModel: Object {
    override static func primaryKey() -> String {
        return "id"
    }
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var recordDate: Date = Date()
    @objc dynamic var text: String = ""
    
}

