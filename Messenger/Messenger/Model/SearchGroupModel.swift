//
//  SearchGroupModel.swift
//  Messenger
//
//  Created by Polly on 29.07.2022.
//

import Foundation
import RealmSwift

struct SearchGroup: Codable {
    let response: ResponseSearchGroup
}

// MARK: - Response
struct ResponseSearchGroup: Codable {
    let count: Int
    let items: [ItemSearchGroup]
}

// MARK: - Item
class ItemSearchGroup: Codable {
    var id: Int
    var name: String
    let type: String
    var photo50: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case photo50 = "photo_50"
    }
}
