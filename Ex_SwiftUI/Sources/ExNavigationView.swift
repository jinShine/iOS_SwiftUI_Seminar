//
//  ExNavigationView.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/02/01.
//

import SwiftUI

struct ExNavigationView: View {

  init() {
    // 요렇게 UIKit을 통해서 초기 셋팅을 할 수도 있다.
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.brown]
  }

    var body: some View {
      NavigationView {
        List {
          NavigationLink("Click me") {
            Text("detail")
          }
          NavigationLink {
            Text("Destination")
          } label: {
            HStack {
              Image(systemName: "person")
              Text("Link")
            }
          }

        }


        .navigationTitle("타이틀")
        .navigationBarTitleDisplayMode(.inline)
      }
    }
}

struct ExNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        ExNavigationView()
    }
}
