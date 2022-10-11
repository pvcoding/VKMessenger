//
//  SessionHelpers.swift
//  Messenger
//
//  Created by Polly on 09.09.2022.
//

import Foundation
import Alamofire
import PromiseKit


enum InternalError: LocalizedError {
    case unexpected
}

extension Session {
    func request<T: Codable>(_ urlRequestConvertible: APIRouterStructer, on queue: DispatchQueue) -> Promise<T> {
       
            return Promise<T> { seal in
                queue.async {
                    self.request(urlRequestConvertible).responseDecodable { (response: DataResponse<T, AFError>) in
                    guard response.response != nil else {
                        if let error = response.error {
                            seal.reject(error)
                        } else {
                            print("Error Session Request")
                            seal.reject(InternalError.unexpected)
                        }
                        return
                    }
                    
                    switch response.result {
                    case .success(let value):
                        seal.fulfill(value)
                    case .failure(let error):
                        seal.reject(error)
                    }
                }.resume()
            }
        }
    }
}


