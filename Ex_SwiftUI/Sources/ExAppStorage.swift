//
//  ExAppStorage.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/02/07.
//

import SwiftUI

// AppStorage
// 간단한 데이터 로컬 저장소

struct ExAppStorage: View {

  @AppStorage("mode") var mode = false

    var body: some View {
      ZStack {
        mode ? Color.orange : Color.gray

        Button("Button") {
          mode.toggle()
        }
      }
    }
}

struct ExAppStorage_Previews: PreviewProvider {
    static var previews: some View {
        ExAppStorage()
    }
}
