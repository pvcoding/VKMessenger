//
//  GroupModel.swift
//  Messenger
//
//  Created by Polly on 26.07.2022.
//

import Foundation
import RealmSwift

struct Groups: Codable {
    let response: ResponseGroup
}

// MARK: - Response
struct ResponseGroup: Codable {
    let count: Int
    let items: [ItemGroup]
}

// MARK: - Item
class ItemGroup:  Object, Codable {
  
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var photo50: String = ""
    
    override class func primaryKey() -> String? {
            return "id"
        }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo50 = "photo_50"

    }
}
