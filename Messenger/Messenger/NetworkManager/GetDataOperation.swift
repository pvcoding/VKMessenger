//
//  GetDataOperation.swift
//  Messenger
//
//  Created by Polly on 01.09.2022.
//

import Foundation
import Alamofire

class GetDataOperation: AsyncOperation {
  
    override func cancel() {
        request.cancel()
        super.cancel()
    }
    
    private let request : DataRequest
    var data: Data?
    
    init(url: String) {
        self.request = Session.default.request(url)
    }
    
    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
        }
    }
    
    
}
