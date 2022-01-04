//
//  ExButton.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/01/05.
//

import SwiftUI

// Button
// State(Property wrapper)
// 하나의 뷰 안에서 사용되는 값

struct ExButton: View {

  @State
  var didSelected: Bool = false

  var changeButtonImage: String {
    didSelected ? "pencil" : "circle"
  }

    var body: some View {
      VStack {
        Button {
          didSelected.toggle()
        } label: {
          // 버튼의 형태를 잡는곳
          HStack {
            Image(systemName: changeButtonImage)
            Text("button Click")
          }
        }

        Text("current status vlaue: \(didSelected.description)")
      }
    }
}

struct ExButton_Previews: PreviewProvider {
    static var previews: some View {
        ExButton()
    }
}
