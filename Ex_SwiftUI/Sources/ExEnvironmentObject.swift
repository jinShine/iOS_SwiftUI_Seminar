//
//  ExEnvironmentObject.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/02/04.
//

import SwiftUI

// EnvironmentObject
// 싱글톤과 비슷하다

class MyInfoModel: ObservableObject {
  @Published var name = ""
  @Published var photoURL = "http://www.photo~"
  var token = ""
}

struct ExEnvironmentObject: View {

  // 생성되지 않고, 타입으로 사용해야 됨.
  @EnvironmentObject var myInfo: MyInfoModel

    var body: some View {
      Text(myInfo.photoURL)
    }
}

struct ExEnvironmentObject_Previews: PreviewProvider {
    static var previews: some View {
      ExEnvironmentObject().environmentObject(MyInfoModel()) // 생성되는곳에서 주입을 해줘야 한다.
    }
}
