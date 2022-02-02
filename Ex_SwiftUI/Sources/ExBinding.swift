//
//  ExBinding.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/02/02.
//

import SwiftUI

struct ExBinding: View {

  @State var myBool = false

    var body: some View {
      NavigationView {
        VStack {
          NavigationLink {
            Text("Destination")
            DetailView(toggleValue: $myBool)
          } label: {
            Text("Navigate")
          }

          Toggle(myBool.description, isOn: $myBool)
        }
      }
    }
}

struct DetailView: View {

  // Binding은 값을 받아서 사용할때 사용
  @Binding var toggleValue: Bool

  var body: some View {
    Toggle("detail toggle", isOn: $toggleValue)
  }
}

struct ExBinding_Previews: PreviewProvider {
    static var previews: some View {
        ExBinding()
    }
}
