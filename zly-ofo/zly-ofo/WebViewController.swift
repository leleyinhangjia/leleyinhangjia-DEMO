//
//  WebViewController.swift
//  zly-ofo
//
//  Created by 郑乐银 on 2017/5/18.
//  Copyright © 2017年 郑乐银. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!

    var  wkWebView : WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.title = "活动中心"


        
    wkWebView = WKWebView(frame: self.view.frame)
    view.addSubview(wkWebView)
    let url = URL(string: "http://m.ofo.so/active.html")!
    let request = URLRequest(url: url);
    wkWebView.load(request)
        
        
        
    }
    

}
