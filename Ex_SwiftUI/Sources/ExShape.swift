//
//  ExShape.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/01/05.
//

import SwiftUI

struct ExShape: View {
    var body: some View {
      HStack(spacing: 20) {
        VStack {
          Rectangle()
            .foregroundColor(.blue)
            .frame(width: 150, height: 150)

          RoundedRectangle(cornerRadius: 16, style: .circular)
            .foregroundColor(.brown)
            .frame(width: 150, height: 150)

          Circle()
            .foregroundColor(.mint)
            .frame(width: 150, height: 150)

          Capsule()
            .foregroundColor(.yellow)
            .frame(width: 50, height: 150)

          Ellipse()
            .foregroundColor(.teal)
            .frame(width: 100, height: 150)
        }
        VStack {
          Rectangle()
            .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round, dash: [10, 20], dashPhase: 10))
        }
      }.padding()
    }
}

struct ExShape_Previews: PreviewProvider {
    static var previews: some View {
        ExShape()
    }
}
