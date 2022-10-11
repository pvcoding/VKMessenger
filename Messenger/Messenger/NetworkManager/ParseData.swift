//
//  ParseData.swift
//  Messenger
//
//  Created by Polly on 01.09.2022.
//

import Foundation

class ParseData: Operation {
    
    var outputData: NewsResponse?
    
    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let data = getDataOperation.data else { return }
        do {
            let response = try JSONDecoder().decode(News.self, from: data).response
            outputData = response
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}
