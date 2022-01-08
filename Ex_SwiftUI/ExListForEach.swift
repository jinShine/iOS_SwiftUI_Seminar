//
//  ExListForEach.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/01/09.
//

import SwiftUI

// List

// Model

// ForEach에 id있는 방법
// struct LocationInfo: Hashable {
//    var city = ""
//    var weather = ""
//  }

// ForEach에 id가 없는 방법
struct LocationInfo: Identifiable {
  var id = UUID()
  var city = ""
  var weather = ""
}

struct ExListForEach: View {

  @State private var locations = [
    LocationInfo(city: "서울", weather: "맑음"),
    LocationInfo(city: "대전", weather: "비"),
    LocationInfo(city: "대구", weather: "눈"),
    LocationInfo(city: "부산", weather: "맑음"),
    LocationInfo(city: "인천", weather: "맑음"),
    LocationInfo(city: "경기", weather: "맑음")
  ]

  var body: some View {
    List {
      // \.self = 데이터 하나하나를 id로 하겠다라는 의미, 꼭 모델에 Hashable프로토콜을 지정해줘야한다.
//        ForEach(locations, id: \.self) { item in
//          HStack {
//            Text("\(item.city)")
//            Text("\(item.weather)")
//          }
//        }

      // id 없이 사용할때는 Identifiable 프로토콜을 준수해야한다.
//        ForEach(locations) { item in
//          HStack {
//            Text("\(item.city)")
//            Text("\(item.weather)")
//          }
//        }

      // index로 접근해서 사용하는 방법
      ForEach(0..<locations.count) { index in
        HStack {
          Text(locations[index].city)
          Text(locations[index].weather)
        }
      }
    }
  }
}

struct ExListForEach_Previews: PreviewProvider {
  static var previews: some View {
    ExListForEach()
  }
}
