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
        let url = try apiRouter.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(apiRouter.path))
        urlRequest.httpMethod = apiRouter.method.rawValue
        urlRequest.timeoutInterval = apiRouter.timeOut
        
        if let parameters = apiRouter.parameters {
            urlRequest = try apiRouter.encoding.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }   
}

enum APIRouter{

    case groups
    // some other cases
    
    var baseURL: String {
        switch self {
        case .groups:
            return "https://api.vk.com"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .groups:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .groups:
            return "/method/groups.get"
        }
    }
    
    var encoding: ParameterEncoding {
        switch method {
        default:
            return URLEncoding.default
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .groups: return [ "access_token": SessionInfo.shared.token,
                               "user_id": String(SessionInfo.shared.userId),
                               "extended": "1",
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
