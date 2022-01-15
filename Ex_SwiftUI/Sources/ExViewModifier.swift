//
//  ExViewModifier.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/01/15.
//

import SwiftUI

struct ExViewModifier: View {
    var body: some View {
      VStack {
        Text("Hello, World!")
          .modifier(MyTextStyle())
        Text("Hello, World!")
          .customFont()
      }
    }
}

// 커스텀 만드는 방법 1
// protocol -> ViewModifier
struct MyTextStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.body.weight(.bold))
      .foregroundColor(.blue)
  }
}

// 커스텀 만드는 방법 2
extension Text {
  func customFont() -> Text {
    self
      .font(.title)
      .fontWeight(.bold)
      .foregroundColor(.black)
  }
}

struct ExViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        ExViewModifier()
    }
}
