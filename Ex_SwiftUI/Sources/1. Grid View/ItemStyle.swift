//
//  ItemStyle.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/02/07.
//

import SwiftUI

struct ItemStyle: View {

  var items: [ContentItem]
  @Binding var gridType: GridType

    var body: some View {
      ScrollView {
        LazyVGrid(columns: gridType.columns) {
          ForEach(items) { item in
            switch gridType {
            case .single:
              SingleRow(item: item)
            default:
              Image(item.imageName)
                .resizable()
                .aspectRatio(.init(width: 1, height: 1), contentMode: .fit)
            }
          }
        }
      }
      .animation(.default, value: gridType)
    }
}

struct ItemStyle_Previews: PreviewProvider {
    static var previews: some View {
      ItemStyle(items: ContentItem.dummyData, gridType: .constant(.single))
    }
}
