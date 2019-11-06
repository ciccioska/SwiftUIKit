import XCTest
@testable import SwiftUIKit

@available(iOS 9.0, *)
final class ObserveTests: XCTestCase {
    func testObserve() {
        let label = Label("SomeString")
            .accessibility(identifier: "SomeID")
            .padding()
            .width(equalTo: label)
            .debug()
        
        assert(label.accessibilityLabel == "SomeString")
    }
    
    static var allTests = [
        ("testObserve", testObserve)
    ]
}
