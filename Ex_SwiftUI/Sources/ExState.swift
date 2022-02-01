//
//  ExState.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/02/02.
//

import SwiftUI

struct ExState: View {

  // var myName = "BUZZ"
  @State var myName = "BUZZ"

    var body: some View {
      VStack {
        Text(myName)
          .padding()
        Button("Change name") {
          myName = "BUZZ Kim"
        }
      }
    }
}

struct ExState_Previews: PreviewProvider {
    static var previews: some View {
        ExState()
    }
}
