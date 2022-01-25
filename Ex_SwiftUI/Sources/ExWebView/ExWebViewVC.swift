//
//  ExWebViewVC.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/01/26.
//

import Foundation
import UIKit
import WebKit

class ExWebViewVC: UIViewController, WKNavigationDelegate {

  var webView: WKWebView!

  var urlString = "https://google.com"
  override func viewDidLoad() {
    super.viewDidLoad()

      // 수신을 받을 수 있는 상태
      let contentController = WKUserContentController()
      contentController.add(self, name: "iPhoneInfo")

    let configuration = WKWebViewConfiguration()
    configuration.userContentController = contentController

    webView = WKWebView(frame: self.view.bounds, configuration: configuration)
    webView.frame = view.frame
    webView.navigationDelegate = self
    view.addSubview(webView)

//    webView.load(.init(url: .init(string: urlString)!))

    let localFile = Bundle.main.path(forResource: "TestWeb", ofType: "html")
    let url = URL(fileURLWithPath: localFile ?? "")
    let request = URLRequest(url: url)

    webView.load(request)

  }

  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    self.webView.evaluateJavaScript("document.title") { result, error in
      self.navigationItem.title = result as? String
    }
  }


}

extension ExWebViewVC: WKScriptMessageHandler {

  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    if message.name == "iPhoneInfo" {
      print("call native")
    }
  }
}
