//
//  DetailViewController.swift
//  07-WhitehousePetitions
//
//  Created by Laura Calinoiu on 23/10/15.
//  Copyright © 2015 3Smurfs. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var detailItem: [String: String]!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let body = detailItem["body"]{
            var html = "<html>"
            html += "<head>"
            html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
            html += "<style> body {font-size: 150%; } </style>"
            html += "</head>"
            html += "<body>"
            html += body
            html += "</body>"
            html += "</html>"
            
            webView.loadHTMLString(html, baseURL: nil)
        }
    }
    
    override func loadView() {
        webView = WKWebView()
        self.view = webView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

