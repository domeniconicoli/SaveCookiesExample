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
    var oldWebView: UIWebView!
    
    override func loadView() {
        
        if #available(iOS 11, *) {
            let preferences = WKPreferences()
            preferences.javaScriptEnabled = true
            preferences.javaScriptCanOpenWindowsAutomatically = true
            let webConfiguration = WKWebViewConfiguration()
            webConfiguration.preferences = preferences
            
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            
            let userAgentValue = "Chrome/56.0.0.0 Mobile"
            webView.customUserAgent = userAgentValue
            webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            webView.uiDelegate = self
            view = webView
            
        } else {
            oldWebView = UIWebView()
            oldWebView.frame =  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            oldWebView.delegate = self
            view = oldWebView
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let myURL = URL(string: "https://www.medium.com")
        let myRequest = URLRequest(url: myURL!)
        
        if #available(iOS 11, *) {
            webView.load(myRequest)
            webView.navigationDelegate = self
        } else {
            oldWebView.loadRequest(myRequest)
            oldWebView.delegate = self
        }
        
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
