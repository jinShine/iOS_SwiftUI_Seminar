//
//  ExObservableObject.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/02/02.
//

import SwiftUI

// ObservableObject
// 클래스에서만 사용가능하며, 값이 업데이트 될 때 마다 뷰를 갱신하는 PropertyWrapper

class MyInfo: ObservableObject {
  @Published var age = 32
  @Published var name = "buzz" // @Published가 없으면 변경을 감지 하지 않는다.
}

struct ExObservableObject: View {

  @ObservedObject var myInfo = MyInfo()

    var body: some View {
      VStack {
        Text(myInfo.name)
          .padding()

        Button("change name") {
          myInfo.name = "BUZZ"
        }
      }

    }
}

struct ExObservableObject_Previews: PreviewProvider {
    static var previews: some View {
        ExObservableObject()
    }
}
