//
//  APIRouter.swift
//  Messenger
//
//  Created by Polly on 09.09.2022.
//

import Foundation
import Alamofire


struct APIRouterStructer: URLRequestConvertible {
    let apiRouter: APIRouter
    func asURLRequest() throws -> URLRequest {
        let baseURL = apiRouter.scheme + apiRouter.host
        let url = try baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(apiRouter.path))
        urlRequest.httpMethod = apiRouter.method.rawValue
        urlRequest.timeoutInterval = apiRouter.timeOut

        if let parameters = apiRouter.parameters {
            urlRequest = try apiRouter.encoding.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }   
}

struct APIRouterStructerWithComponents {
    let apiRouter: APIRouter
   
    func url() -> URL {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = apiRouter.scheme
        urlConstructor.host = apiRouter.host
        urlConstructor.path = apiRouter.path
        urlConstructor.queryItems = apiRouter.parameters!.map { URLQueryItem(name: $0, value: $1) }
            return urlConstructor.url!
    }
    
    
    
}

enum APIRouter{

    case groups
    case friends
// some other cases
    
    
    var scheme: String {
        switch self {
        case .groups:
            return "https://"
        case .friends:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .groups, .friends:
            return "api.vk.com"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .groups, .friends:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .groups:
            return "/method/groups.get"
        case .friends:
            return "/method/friends.get"
        }
    }
    
    var encoding: ParameterEncoding {
        switch method {
        default:
            return URLEncoding.default
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        case .groups:
            return [ "access_token": SessionInfo.shared.token,
                     "user_id": String(SessionInfo.shared.userId),
                      "extended": "1",
                      "v": "5.130"]
        case .friends:
            return [ "access_token": SessionInfo.shared.token,
                     "user_id": String(SessionInfo.shared.userId),
                     "fields": "photo_50",
                     "order" : "name",
                     "v": "5.130"]
        }
    }
    
    var timeOut: TimeInterval {
        switch self {
        default:
            return 20
        }
    }
    
    
}
