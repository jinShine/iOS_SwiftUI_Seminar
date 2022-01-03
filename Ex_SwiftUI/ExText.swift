//
//  ExText.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/01/03.
//

import SwiftUI

struct ExText: View {
    var body: some View {
      VStack(alignment: .center, spacing: 30) {
        Text("폰트와 굵기 설정")
          .font(.title)
          .fontWeight(.black)

        Text("글자색은 foreground, 배경은 background")
          .foregroundColor(.white)
          .padding()
          .background(.black)

        Text("커스텀 폰트, 볼드체, 이탤릭체, 밑줄, 취소선")
          .font(.custom("Menlo", size: 16))
          .bold()
          .italic()
          .underline()
          .strikethrough(color: .blue)

        Text("라인수 제한과 \n 텍스트 정렬 기능입니다 \n 이건 안보입니다.")
          .lineLimit(2)
          .multilineTextAlignment(.trailing)
          .fixedSize()

        // 2개 이상의 텍스트를 하나로 묶어서 동시에 적용할 수도 있다.
        (
          Text("자간과 기준선").kerning(8)
          + Text("  조정도 쉽게 가능합니다.").baselineOffset(-8)
            .font(.system(size: 16))
            .bold()
        )
      }
    }
}

struct ExText_Previews: PreviewProvider {
    static var previews: some View {
        ExText()
    }
}
