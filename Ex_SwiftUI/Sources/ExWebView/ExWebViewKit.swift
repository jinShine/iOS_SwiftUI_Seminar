//
//  ExWebViewKit.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/01/26.
//

import Foundation
import WebKit
import SwiftUI

// UIView <-> SwiftUI인터페이스와 맞추기 위해 UIViewRepresentable을 준수 한다.
struct CommonWebView: UIViewRepresentable {

  var url: String

  func makeUIView(context: Context) -> some UIView {
    let webView = WKWebView()
    let url = URL(string: url)!
    let request = URLRequest(url: url)
    webView.load(request)
    return webView
  }

  func updateUIView(_ uiView: UIViewType, context: Context) {

  }
}

// UIViewController
struct CommonWebView2: UIViewControllerRepresentable {
  func makeCoordinator() -> () {

  }

  func makeUIViewController(context: Context) -> some UIViewController {
    let webVC = ExWebViewVC()
    let navi = UINavigationController(rootViewController: webVC)

    return navi
  }

  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

  }
}
