//
//  ExTabView.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/02/01.
//

import SwiftUI

struct ExTabView: View {
    var body: some View {
      TabView {
        First().tabItem {
          Image(systemName: "person")
          Text("person")
        }.edgesIgnoringSafeArea(.top)

        Second().tabItem {
          Image(systemName: "music.mic")
          Text("music")
        }
      }
    }
}

struct First: View {
  var body: some View {
    ZStack {
      Color.orange
      Text("First")
    }
  }
}

struct Second: View {
  var body: some View {
    ZStack {
      Color.orange
      Text("Second")
    }
  }
}

struct ExTabView_Previews: PreviewProvider {
    static var previews: some View {
        ExTabView()
    }
}
