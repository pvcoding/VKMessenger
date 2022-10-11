//
//  ReloadTableController.swift
//  Messenger
//
//  Created by Polly on 01.09.2022.
//

import Foundation
import UIKit

class ReloadTableController: Operation {
    var controller: TableControllerProtocol
    
    init(controller: TableControllerProtocol) {
        self.controller = controller
    }
    
    override func main() {
        guard let parseData = dependencies.first as? ParseData else { return }
        controller.newsResponse = parseData.outputData
        controller.reloadData()
    }
}
