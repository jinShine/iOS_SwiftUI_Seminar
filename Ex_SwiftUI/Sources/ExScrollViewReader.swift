//
//  ExScrollViewReader.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/02/02.
//

import SwiftUI

struct ExScrollViewReader: View {
  @State private var proxy: ScrollViewProxy?

    var body: some View {
      VStack {
        Button("Scroll To") {
          withAnimation(.easeIn) {
            proxy?.scrollTo(20, anchor: .bottom)
          }
        }
        ScrollView {
          ScrollViewReader { proxy in
            ForEach(0..<50, id: \.self) { index in
              Text("\(index)")
                .padding()
            }
            .onAppear { // 데이터가 set될때 한번 호출된다.
              print("onAppear")
              self.proxy = proxy
            }
          }
        }
      }
    }
}

struct ExScrollViewReader_Previews: PreviewProvider {
    static var previews: some View {
        ExScrollViewReader()
    }
}
