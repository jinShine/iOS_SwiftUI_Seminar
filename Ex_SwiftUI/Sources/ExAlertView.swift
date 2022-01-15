//
//  ExAlertView.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/01/16.
//

import SwiftUI

struct ExAlertView: View {

  @State private var isShowAlert = false

  @State private var printTitle = ""

  var body: some View {
    VStack {
      Button("show alert1") {
        isShowAlert.toggle()
      }
      .alert("타이틀", isPresented: $isShowAlert) {
        Button("확인", action: {
          printTitle = "확인 선택"
        })
        Button("취소", role: .cancel, action: {
          printTitle = "취소 선택"
        })
        Button("삭제", role: .destructive, action: {
          printTitle = "삭제 선택"
        })
      } message: {
        Text("메세지 표시")
      }

      Text("\(printTitle)")
    }
  }
}

struct ExAlertView_Previews: PreviewProvider {
  static var previews: some View {
    ExAlertView()
  }
}
