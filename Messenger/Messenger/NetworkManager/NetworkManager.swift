//
//  NetworkManager.swift
//  Messenger
//
//  Created by Polly on 19.07.2022.
//

import Foundation
import UIKit

// URLSession, JSONDecoder

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
  

    
   // MARK: LoadFriends

    func loadFriends(completion: @escaping ([UserItem]) ->()) {
//
//        let userIdString = String(SessionInfo.shared.userId)
//
        let configuration = URLSessionConfiguration.default

        let session = URLSession(configuration: configuration)
//
//        var urlConstructor = URLComponents()
//
//        urlConstructor.scheme = "https"
//        urlConstructor.host = "api.vk.com"
//        urlConstructor.path = "/method/friends.get"
//
//        urlConstructor.queryItems = [
//            URLQueryItem(name: "access_token", value: SessionInfo.shared.token),
//            URLQueryItem(name: "user_id", value: userIdString),
//            URLQueryItem(name: "fields", value: "photo_50"),
//            URLQueryItem(name: "order", value: "name"),
//            URLQueryItem(name: "v", value: "5.130")
//
//        ]
//
//        guard let url = urlConstructor.url else { return }

        
        let apiRouter = APIRouterStructerWithComponents(apiRouter: .friends)
        let url = apiRouter.url()
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }

            do {
                let users = try JSONDecoder().decode(User.self, from: data).response.items
                completion(users)
            } catch {
                print(error.localizedDescription)
            }
        }

        task.resume()
    }

    //MARK: loadFotos

    func loadFotos(token: String, userId: Int, completion: @escaping ([ItemPhoto]) ->()) {

        let userIdString = String(userId)

        let configuration = URLSessionConfiguration.default

        let session = URLSession(configuration: configuration)

        var urlConstructor = URLComponents()

        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/photos.getAll"

        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "owner_id", value: userIdString),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.130")

        ]

        guard let url = urlConstructor.url else { return }

        let task = session.dataTask(with: url) { (data, response, error) in

            guard let data = data else { return }

            do {
                let photos = try JSONDecoder().decode(PhotoProfile.self, from: data).response.items
              
                completion(photos)
            } catch {
                print(error.localizedDescription)
            }
        }
                task.resume()
    }


//
    //MARK: LoadSearchGroups

    func loadSearchGroups(token: String, searchText: String, completion: @escaping ([ItemSearchGroup]) ->()) {

        let configuration = URLSessionConfiguration.default

        let session = URLSession(configuration: configuration)

        var urlConstructor = URLComponents()

        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.search"

        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "type", value: "group"),
            URLQueryItem(name: "count", value: "50"),
            URLQueryItem(name: "q", value: searchText),
            URLQueryItem(name: "v", value: "5.130")

        ]

        guard let url = urlConstructor.url else { return }

        let task = session.dataTask(with: url) { (data, response, error) in

            guard let data = data else { return }

            do {
                let searchGroup = try JSONDecoder().decode(SearchGroup.self, from: data).response.items
                completion(searchGroup)
            } catch {
                print(error)
            }
        }

                task.resume()
    }

    //MARK: GetNewsUrl
    func getNewsUrl(token: String) -> String {
      
        var urlConstructor = URLComponents()

        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/newsfeed.get"

        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "max_photos", value: "1"),
            URLQueryItem(name: "v", value: "5.130")

        ]

        guard let url = urlConstructor.string else { return "" }
        return url
        
        
    }

    //MARK: - Join Group
    
    func joinGroup(token: String, groupID: String) {

        let configuration = URLSessionConfiguration.default

        let session = URLSession(configuration: configuration)

        var urlConstructor = URLComponents()

        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.join"

        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "group_id", value: groupID),
            URLQueryItem(name: "v", value: "5.130")

        ]

        guard let url = urlConstructor.url else { return }

        let task = session.dataTask(with: url)

        task.resume()
    }
  
    //MARK: - Leave Group

    func leaveGroup(token: String, groupID: String) {

        let configuration = URLSessionConfiguration.default

        let session = URLSession(configuration: configuration)

        var urlConstructor = URLComponents()

        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.leave"

        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "group_id", value: groupID),
            URLQueryItem(name: "v", value: "5.130")

        ]

        guard let url = urlConstructor.url else { return }

        let task = session.dataTask(with: url)

        task.resume()
    }
}
