//
//  AppManualVC.swift
//  GotPark
//
//  Created by Connor Clarkson on 2019-11-23.
//  Copyright © 2019 Connor Clarkson. All rights reserved.
//

import UIKit
import WebKit

class AppManualVC: UIViewController, WKUIDelegate  {
    @IBOutlet var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = Bundle.main.url(forResource: "AppManual", withExtension: "html")
        let requestObj = URLRequest(url: url!);
        webView.load(requestObj);
        // Do any additional setup after loading the view.
    }
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    

}
