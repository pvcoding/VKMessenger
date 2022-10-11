//
//  UserModel.swift
//  Messenger
//
//  Created by Polly on 14.04.2022.
//

import Foundation
import RealmSwift


struct Section {
    var title: String
    var items: [UserItem]
}

struct User: Codable {
    let response: UserResponse
}

struct UserResponse: Codable {
    let count: Int
    let items:[UserItem]
}

class UserItem: Object, Codable {
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var photo50: String = ""
 
    override class func primaryKey() -> String? {
            return "id"
        }
        
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"
    }
}

