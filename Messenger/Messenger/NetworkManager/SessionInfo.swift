//
//  Session.swift
//  Messenger
//
//  Created by Polly on 13.07.2022.
//

import Foundation

class SessionInfo {
    
    static let shared = SessionInfo()
    
    private init() { }
    
    var token : String = ""
    var userId = Int()
    
}
