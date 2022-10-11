//
//  ConnectionSettings.swift
//  Messenger
//
//  Created by Polly on 09.09.2022.
//

import Foundation
import Alamofire

struct ConnectionSettings {}

extension ConnectionSettings {
    static func sessionManager() -> Session {
        let configuration = URLSessionConfiguration.default
        let sessionManager = Session(configuration: configuration)
        return sessionManager
    }
}
