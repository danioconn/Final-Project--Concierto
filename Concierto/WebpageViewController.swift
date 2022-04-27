//
//  WebpageViewController.swift
//  Concierto
//
//  Created by Danielle O'Connor on 4/26/22.
//

import UIKit
import WebKit

class WebpageViewController: UIViewController, WKNavigationDelegate {
    var url = ""
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        let theUrl = URL(string: url)!
        webView.load(URLRequest(url: theUrl))
        webView.allowsBackForwardNavigationGestures = true


    }
    

}
