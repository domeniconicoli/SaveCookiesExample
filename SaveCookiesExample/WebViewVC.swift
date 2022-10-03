//
//  WebViewVC.swift
//  SaveCookiesExample
//
//  Created by Domo on 26/11/2019.
//  Copyright © 2019 Domo. All rights reserved.
//

import UIKit
import WebKit

class WebViewVC: UIViewController, WKUIDelegate, WKNavigationDelegate, UIWebViewDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.preferences = preferences
        let userAgentValue = "Chrome/56.0.0.0 Mobile"
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.customUserAgent = userAgentValue
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.uiDelegate = self
        view = webView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let myURL = URL(string: "https://www.medium.com")
        let myRequest = URLRequest(url: myURL!)
        
        webView.load(myRequest)
        webView.navigationDelegate = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if #available(iOS 11, *) {
            let dataStore = WKWebsiteDataStore.default()
            dataStore.httpCookieStore.getAllCookies({ (cookies) in
                print(cookies)
            })
        } else {
            guard let cookies = HTTPCookieStorage.shared.cookies else {
                return
            }
            print(cookies)
        }
        
    }
    
}
