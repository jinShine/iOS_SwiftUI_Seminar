//
//  ExListForEachSection.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/01/09.
//

import SwiftUI

// Section
// row
// row
// row

// 1. 기본구조
// 2. data를 원하는 형태로 가공해야됨.

struct Animal: Identifiable {
  let id = UUID()
  let name: String
  let index: Int
}

struct ExListForEachSection: View {

  var animalList = [
    Animal(name: "dog", index: 1),
    Animal(name: "pat", index: 4),
    Animal(name: "bird", index: 2),
    Animal(name: "dolpin", index: 5),
    Animal(name: "dragon", index: 3),
    Animal(name: "dolpin", index: 6),
    Animal(name: "dolpin", index: 7),
    Animal(name: "dolpin", index: 8),
    Animal(name: "dolpin", index: 9),
  ]

  var animalGrouped: [String: [Animal]] {
    Dictionary(grouping: animalList) { $0.name }
  }

  var groupKey: [String] {
    animalGrouped.map { $0.key }
  }

  var body: some View {

    List {
//      Section {
//        Text("A")
//        Text("B")
//        Text("C")
//      } header: {
//        HStack {
//          Image(systemName: "trash")
//          Text("Section area")
//        }
//      }

      ForEach(groupKey, id: \.self) { key in
        Section {
          ForEach(animalGrouped[key]!) { item in
            Text(item.name)
          }
        } header: {
          Text(key)
        }
      }
    }
  }
}

struct ExListForEachSection_Previews: PreviewProvider {
  static var previews: some View {
    ExListForEachSection()
  }
}
