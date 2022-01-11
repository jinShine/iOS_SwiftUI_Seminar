//
//  ExStackView.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/01/02.
//

import SwiftUI

struct ExStackView: View {
    var body: some View {
      VStack {
        Text("도형 만들기").font(.largeTitle).fontWeight(.heavy)
        HStack {
          Text("둥근 모양").font(.title)
          Spacer()
        }
        ZStack {
          Rectangle().frame(height: 10)
          HStack {
            Circle().fill(.yellow)
            Ellipse().fill(.green)
            Capsule().fill(.orange)
            RoundedRectangle(cornerRadius: 30).fill(.gray)
          }
        }

        HStack {
          Text("각진 모양").font(.title)
          Spacer()
        }
        ZStack {
          Rectangle().frame(height: 10)
          HStack {
            Color.red
            Rectangle().fill(.blue)
            RoundedRectangle(cornerRadius: 0).fill(.purple)
          }
        }


        // Overlay와 Background

        // 아래의 ZStack을 Ovserlay와 똑같이 할 수 있다.
        ZStack {
          Rectangle().fill(.gray).frame(width: 150, height: 150)
          Rectangle().fill(.yellow).frame(width: 150, height: 150)
        }

        // Overlay 사용법
        Rectangle().fill(.brown).frame(width: 150, height: 150)
          .overlay {
            Rectangle().fill(.blue)
          }

        // Background 사용법
        // Overlay와 마찬가지로 뷰 원본의 공간을 기준으로 뷰를 중첩하는 것 같지만 위가 아니라, 아래 방향으로 쌓인다
        Rectangle().fill(.brown).frame(width: 150, height: 150)
          .background {
            Rectangle().fill(.blue)
          }


      }.padding()
    }
}

struct ExStackView_Previews: PreviewProvider {
    static var previews: some View {
        ExStackView()
    }
}
