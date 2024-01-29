//
//  BookDetailVC.swift
//  BooksDemoAPP
//
//  Created by Naveen on 27/01/24.
//

import UIKit
import WebKit

class BookDetailVC: UIViewController,WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    var bookUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.navigationController?.navigationBar.prefersLargeTitles = false
        
        webView.navigationDelegate = self
        ActivityIndicatorManager.shared.showActivityIndicator(in: self.view)
        if let url = URL(string: bookUrl) {
                let request = URLRequest(url: url)
            webView.load(request)
            }
        
    }
    
    // WKNavigationDelegate method
    
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("WebView has finished loading.")
            ActivityIndicatorManager.shared.hideActivityIndicator()
        }

}
