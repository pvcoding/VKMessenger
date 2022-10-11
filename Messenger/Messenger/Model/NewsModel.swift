//
//  NewsModel.swift
//  Messenger
//
//  Created by Polly on 26.07.2022.
//

import Foundation

struct News: Codable {
    let response: NewsResponse
}

// MARK: - Response
struct NewsResponse: Codable {
    let items: [NewsItem]
    let profiles: [Profile]
    let groups: [NewsGroup]
}

// MARK: - Item
struct NewsItem: Codable {
    let sourceID: Int
    let date: Int
    let text: String?
    let attachments: [Attachment]?
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?
    let views: Views?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case text
        case attachments
        case comments
        case likes
        case reposts
        case views
    }
}

// MARK: - Group
struct NewsGroup: Codable {
    let id: Int
    let name: String
    let photo50: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo50 = "photo_50"

    }
}
// MARK: - Attachment
struct Attachment: Codable {
    let photo: Photo?
}


// MARK: - Photo
struct Photo: Codable {
    let sizes: [Size]
    let text: String

}

// MARK: - Size
struct Size: Codable {
    let height: Int
    let url: String
    let width: Int
}


// MARK: - Comments
struct Comments: Codable {
    let count: Int
}


// MARK: - Likes
struct Likes: Codable {
    let count: Int
}


// MARK: - Reposts
struct Reposts: Codable {
    let count: Int
}
//
//// MARK: - Views
struct Views: Codable {
    let count: Int
}

// MARK: - Profile
struct Profile: Codable {
    let firstName: String
    let id: Int
    let lastName: String
    let photo50: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"

    }
}


