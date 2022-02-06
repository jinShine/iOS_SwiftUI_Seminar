//
//  ExStateObject.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/02/06.
//

import SwiftUI

// StateObject
// ObservableObject와 비슷

class Info: ObservableObject {
  @Published var score = 0
}

struct ExStateObject: View {

  @ObservedObject var info = Info()
  @StateObject var info2 = Info()

    var body: some View {
      VStack {
        Text("\(info.score)")
          .font(.largeTitle)

        Button("Plus") {
          info.score += 1
        }

//        Text("\(info2.score)")
//          .font(.largeTitle)
//
//        Button("Plus") {
//          info2.score += 1
//        }

        CButton()
      }
    }
}

struct CButton: View {

//  @ObservedObject var info2 = Info()
  @StateObject var info2 = Info()

  var body: some View {
    VStack {
      Text("\(info2.score)")
        .font(.largeTitle)

      Button("Plus") {
        info2.score += 1
      }
    }
  }
}

struct ExStateObject_Previews: PreviewProvider {
    static var previews: some View {
        ExStateObject()
    }
}
