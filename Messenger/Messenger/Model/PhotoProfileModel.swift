//
//  PhotoProfileModel.swift
//  Messenger
//
//  Created by Polly on 29.07.2022.
//

import Foundation

struct PhotoProfile: Codable {
    let response: ResponsePhoto
}

// MARK: - Response
struct ResponsePhoto: Codable {
    let count: Int
    let items: [ItemPhoto]
}

// MARK: - Item
class ItemPhoto:  Codable {
   let ownerID: Int
   let id: Int
   
    let sizes : [PhotoSizes]

    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
        case sizes
        case id
    }
}

class PhotoSizes: Codable {
    let height: Int
    let url: String
    let width: Int
    
}
