import XCTest
import RxSwift
import RxRelay
@testable import SwiftUIKit

@available(iOS 9.0, *)
final class SwiftUIKitTests: XCTestCase {
    func testExample() {
        _ = Label("True")
        
        assert(true)
    }
    
    
    static var allTests = [
        ("testTest", testExample)
    ]
}
