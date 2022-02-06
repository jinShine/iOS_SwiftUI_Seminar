//
//  ExGridView.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/02/07.
//

import SwiftUI

struct ExGridView: View {

  var items = ContentItem.dummyData

  @State private var selectedGridType: GridType = .single

  var body: some View {
    VStack {
      // picker
      GridTypePicker(gridType: $selectedGridType)

      // item style
      ItemStyle(items: items, gridType: $selectedGridType)
    }
  }
}

struct ExGridView_Previews: PreviewProvider {
  static var previews: some View {
    ExGridView()
  }
}
