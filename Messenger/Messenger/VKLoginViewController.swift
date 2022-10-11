//
//  VKLoginViewController.swift
//  Messenger
//
//  Created by Polly on 14.07.2022.
//

import UIKit
import WebKit

class VKLoginViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var components = URLComponents()
          components.scheme = "https"
          components.host = "oauth.vk.com"
          components.path = "/authorize"
          components.queryItems = [
              URLQueryItem(name: "client_id", value: "7798057"),
              URLQueryItem(name: "scope", value: "270342"),
              URLQueryItem(name: "display", value: "mobile"),
              URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
              URLQueryItem(name: "response_type", value: "token"),
              URLQueryItem(name: "v", value: "5.130")
          ]
          
          guard let url = components.url else { return }
        
          
          let request = URLRequest(url: url)

          webView.load(request)

    }

}

extension VKLoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        guard let url = navigationResponse.response.url,
        url.path == "/blank.html",
        let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }

        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                
                return dict
            }
        
        
        guard let token = params["access_token"],
              let userIdString = params["user_id"],
              let userId = Int(userIdString) else {
            decisionHandler(.allow)
            return
        }
        
        SessionInfo.shared.token = token
        print("TOKEN: \(token)")
        SessionInfo.shared.userId = userId
        print("USER_ID: \(userId)")
     
        
        decisionHandler(.cancel)
        
        performSegue(withIdentifier: "goToTabBar", sender: nil)

    }
    
  

}
