import XCTest
import RxSwift
import RxRelay
@testable import SwiftUIKit

@available(iOS 9.0, *)
final class SwiftUIKitTests: XCTestCase {
    func testLabelADA() {
        let label = Label("SomeString")
            .accessibility(identifier: "SomeID")
            .padding()
            .padding()
            .padding()
            .debug()
        
        assert(label.accessibilityLabel == "SomeString")
        assert(label.accessibilityIdentifier == "SomeID")
        assert(label.accessibilityTraits == .staticText)
    }
    
    func testButtonADA() {
        let button = Button("SomeString") { print("Hello") }
            .accessibility(label: nil)
        
        assert(button.accessibilityLabel == "SomeString")
        assert(button.accessibilityIdentifier == nil)
        assert(button.accessibilityTraits == .button)
    }
    
    func testTableRx() {
        let mockSource = BehaviorRelay<[UIView]>(value: [])
        
        let table = Table {
            [
                Label("Cell One"),
                Label("Cell Two"),
                HStack {
                    [
                        Label("Title"),
                        Spacer(),
                        Label("45")
                    ]
                },
            ]
        }
        .bind(source: mockSource)
        
        mockSource.accept([Label("This is just one view!")])
        
        assert(table.currentData.count == 1)
    }
    
    static var allTests = [
        ("testLabelADA", testLabelADA),
        ("testButtonADA", testButtonADA),
        ("TableRx", testTableRx)
    ]
}
