//
//  ExToggle.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/01/08.
//

import SwiftUI

struct ExToggle: View {

  @State private var isOn = false

    var body: some View {
      VStack {
          //      Toggle("스위치 \(isOn.description)", isOn: $isOn) // Binding은 $를 사용해야 한다.
        MyToggle(isOn: $isOn)

        Toggle(isOn: $isOn) {
          HStack {
            Spacer()
            Text("텍스트 부분")
              .padding()
              .foregroundColor(.brown)
              .font(.headline)
          }
        }
      }

    }
}

// 커스텀 해보기

struct MyToggle: View {

  @Binding var isOn: Bool

  var body: some View {
    Toggle("MyToggle \(isOn.description)", isOn: $isOn)
  }
}

struct ExToggle_Previews: PreviewProvider {
    static var previews: some View {
        ExToggle()
    }
}
