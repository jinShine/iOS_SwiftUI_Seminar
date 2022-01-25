//
//  ExWebView.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/01/26.
//

import SwiftUI

// WebView를 아직 제공하지 않기 때문에 UIKit을 이용해야 한다.

struct ExWebView: View {
    var body: some View {
// View를 불러오는 방법
//      CommonWebView(url: "http://apple.com")

      // VC를 불러오는 방법
      CommonWebView2()
    }
}

struct ExWebView_Previews: PreviewProvider {
    static var previews: some View {
        ExWebView()
    }
}
