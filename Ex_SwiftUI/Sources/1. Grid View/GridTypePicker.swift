//
//  GridTypePicker.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/02/07.
//

import SwiftUI

struct GridTypePicker: View {

  @Binding var gridType: GridType

  var body: some View {
    Picker("Grid Type", selection: $gridType) {
      ForEach(GridType.allCases, id: \.self) { type in
        switch type {
        case .single:
          Image(systemName: "rectangle.grid.1x2")
        case .double:
          Image(systemName: "square.grid.2x2")
        case .triple:
          Image(systemName: "square.grid.3x2")
        case .adaptive:
          Image(systemName: "square.grid.4x3.fill")
        }
      }
    }
    .pickerStyle(.segmented)
  }
}
