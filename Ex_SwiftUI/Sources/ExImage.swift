//
//  ExImage.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/01/04.
//

import SwiftUI

// 이미지는 고유의 크기를 유지한다. frame을 지정해도!
// resiable()수식어를 이용해서 사이즈 변경이 가능하며 frame보다 반드시 먼저 와야 한다!

struct ExImage: View {
    var body: some View {
      VStack {

        Image("lific_profile")
          .resizable(capInsets: .init(top: 50, leading: 0, bottom: 0, trailing: 0), resizingMode: .stretch)
          .frame(width: 150, height: 150)

        HStack {
          Image("lific_profile")
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 200)

          Image("lific_profile")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
        }
        .padding()

        HStack {
          Image("lific_profile")
            .resizable()
            // 높이에 1.5배의 넓이를 표현
            .aspectRatio(.init(width: 1.5, height: 1), contentMode: .fit)

          Image("lific_profile")
            .resizable()
            // 너비가 높이보다 0.5비율을 가지도록 조정
            .aspectRatio(0.5, contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()

        }.padding()

        HStack(spacing: 20) {
          Image("lific_profile")
            .resizable()
            .clipShape(Circle())

          Image("lific_profile")
            .resizable()
            .clipShape(Rectangle().inset(by: 10)) // 사방으로 10씩 줄임

          Image("lific_profile")
            .resizable()
            .clipShape(Ellipse().path(in: CGRect(x: 10, y: 10, width: 80, height: 110)))
        }

        // SF Symbol 사용 방법
        HStack(spacing: 20) {
          Image(systemName: "star.circle")
            .imageScale(.small)
          Image(systemName: "star.circle.fill")
            .imageScale(.large)
            .foregroundColor(.brown)
        }

        // Font
        HStack(spacing: 20) {
          Image(systemName: "speaker.1").font(.body)
          Image(systemName: "speaker.2").font(.title)
        }

        // Weight
        HStack(spacing: 20) {
          Image(systemName: "arrow.left").font(Font.title.weight(.black))
          Image(systemName: "arrow.left").font(Font.title.weight(.ultraLight))
        }
      }
    }
}

struct ExImage_Previews: PreviewProvider {
    static var previews: some View {
        ExImage()
    }
}
