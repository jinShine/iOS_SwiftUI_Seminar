//
//  ExTextEditor.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/02/01.
//

import SwiftUI

struct ExTextEditor: View {
  @State private var inputText = ""
    var body: some View {
        TextEditor(text: $inputText)
        .padding()
        // 100글자 제한
        .onChange(of: inputText) { newValue in
          if inputText.count > 100 {
            inputText.removeLast()
          }
        }
    }
}

struct ExTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        ExTextEditor()
    }
}
