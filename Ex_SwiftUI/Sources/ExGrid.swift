//
//  ExGrid.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/01/31.
//

import SwiftUI

// Grid
// CollectionView와 비슷 (바둑판 형태)

struct ExGrid: View {

  var columns: [GridItem] {
//    return [GridItem(.fixed(50))]
//    return [GridItem(.fixed(50)), GridItem(.fixed(50))] // array 갯수만큼 column이 생성된다.
//    return [GridItem(.adaptive(minimum: 30, maximum: 150))] // minimum 기준
    return [GridItem(.flexible(minimum: 30, maximum: 150))] // maximum 기준
  }

    var body: some View {
      ScrollView(.vertical, showsIndicators: true) {
        LazyVGrid(columns: columns) {
          Image(systemName: "music.mic")
            .resizable()
            .aspectRatio(contentMode: .fit)

          Image(systemName: "music.mic")
            .resizable()
            .aspectRatio(contentMode: .fit)

          Image(systemName: "music.mic")
            .resizable()
            .aspectRatio(contentMode: .fit)

          Image(systemName: "music.mic")
            .resizable()
            .aspectRatio(contentMode: .fit)

          Image(systemName: "music.mic")
            .resizable()
            .aspectRatio(contentMode: .fit)
        }
      }
    }
}

struct ExGrid_Previews: PreviewProvider {
    static var previews: some View {
        ExGrid()
    }
}
