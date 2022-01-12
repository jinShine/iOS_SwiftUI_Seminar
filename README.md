# iOS_SwiftUI_Seminar


* **ContentView.swift**
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
    
* **Preview실행**
  * (단축키: Option+Command+P)

* **수식어 적용 유의 사항**
  * 모든 뷰에 공통으로 적용되는 사항으로 각 뷰는 그 자체가 가진 수식어와 뷰 프로토콜이 가진 수식어로 나뉜다.
  * 예) 
    ```swift
    extension Text {
      public func font(_ font: Font?) -> Text
      public func foregroundColor(_ color: Color?) -> Text
    }
    
    extension View {
      public func font(_ font: Font?) -> some View
      public func foreground(_ color: Color?) -> some View
    }
    ```
    * 이름은 동일하지만 텍스트에 정의된 수식어는 반환 타입이 Text이고, 뷰 프로토콜에 정의된 수식어는 반환 타입이 some View로 서로 다르다.
    * 그렇기 때문에 동일하게 사용할 수 없는 수식어가 존재하게 된다
    ```swift
    extension Text {
      // 텍스트에만 있고, 뷰 프로토콜에는 없는 수식어
      public func bold() -> Text
      public func italic() -> Text
    }
    
    extension View {
      // 텍스트에는 없지만 뷰 프로토콜이 사용되는 모듄 뷰에 공통으로 적용되는 수식어
      public func padding(
        _ edges: Edge.Set = .all,
        _ lengthL CGFloat? = nil,
      ) -> some View
    }
    ```
    * 즉 순서가 중요하다
    ```swift
    Text("SwiftUI")
      .font(.title) // Text -> Text 리턴
      .bold()       // Text -> Text 리턴
      .padding()    // View -> padding 수식어 호출 후에는 Text가 아닌 View 반환
    ```
    
    ### 순서
    
