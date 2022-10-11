//
//  ImageCache.swift
//  Messenger
//
//  Created by Polly on 12.08.2022.
//

import Foundation
import UIKit
// NSCache

class ImageCaching {
    
    static let shared = ImageCaching()
    private init() {}
    
    let cache = NSCache<NSString, UIImage>()
    
    func fetchImage(withURL urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(image)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data,
                  error == nil else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                self.cache.setObject(image, forKey: url.absoluteString as NSString)
                completion(image)
            }
        }
        dataTask.resume()
    }
}
