//
//  ContentView.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2021/12/30.
//

import SwiftUI

// Stack
// H V Z

struct ContentView: View {
    var body: some View {
      ZStack {
        Color.cyan
          .edgesIgnoringSafeArea(.all)

        VStack {
          HStack {
            Text("이름 :")
              .padding(.trailing, 30)
            Text("김승진")
          }

          Text("반갑습니다.")
            .font(.largeTitle)
            .foregroundColor(.black)
            .fontWeight(.bold)
            .padding(.top, 50)
            .border(.gray)

          Rectangle()
            .size(CGSize(width: 50, height: 50))

          HStack {
            Spacer().background(.brown)
            Text("Spacer")
          }
        }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
}
