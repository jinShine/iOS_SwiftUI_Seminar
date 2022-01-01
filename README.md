# iOS_SwiftUI_Seminar


* *ContentView.swift*
  * SwiftUI에서는 UIViewController와 UIView를 상속받은 클래스를 사용하지 않는다. 그 대신 뷰 프로토콜은 구조체를 사용해서 body프로퍼티에 UI구성하는 코드를 구현.
  ```swift
  public protocol View {
    associatedtype Body : View
    @ViewBuilder var body: Self.Body { get }
  }
  ```
  * 기존 UIView와 달리 프로토콜로 선언된 것을 볼 수 있다.
  * body를 필수적으로 구현해야 한다.
    * body프로퍼티에서 반환해야 하는 타입이 또 다시 View 프로토콜을 준수하는 타입 (즉, 재귀호출)
    * 재귀호출이 일어나면 안되기 때문에 SwiftUI에서는 Text, Image, Color, Stack 등 Never타입이 사용된다.
    
* Preview실행 (단축키: Option+Command+P)
