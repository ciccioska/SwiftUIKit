import XCTest
@testable import SwiftUIKit

@available(iOS 9.0, *)
final class ObserveTests: XCTestCase {
    func testObserve() {
        let view = View()
        
        view.embed {
            Label("SomeString")
            .accessibility(identifier: "SomeID")
            .padding()
            .width(equalTo: view)
            .debug()
        }
        
        assert("something" == "SomeString")
    }
    
    static var allTests = [
        ("testObserve", testObserve)
    ]
}
