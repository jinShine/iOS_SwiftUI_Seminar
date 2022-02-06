//
//  SingleRow.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/02/07.
//

import SwiftUI

struct SingleRow: View {

  let item: ContentItem

  var body: some View {
    ZStack {
      Image(item.imageName)
        .resizable()
        .aspectRatio(.init(width: 1, height: 1), contentMode: .fit)

      VStack {
        Spacer()
        HStack {
          VStack(alignment: .leading) {
            Text(item.mainTitle)
              .font(.headline)
            Text(item.subTitle)
          }
          Spacer()
        }
        .padding(10)
        .background(.white.opacity(0.5))
      }
    }
  }
}

struct SingleRow_Previews: PreviewProvider {
  static var previews: some View {
    // 테스트 할 수 있는 공간
    Group {
      SingleRow(item: ContentItem(mainTitle: "main", subTitle: "sub", imageName: "image_dog_1"))
        .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/200.0/*@END_MENU_TOKEN@*/))

      SingleRow(item: ContentItem(mainTitle: "main", subTitle: "sub", imageName: "image_dog_1"))
    }
  }
}
