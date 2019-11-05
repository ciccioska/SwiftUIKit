import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SwiftUIKitTests.allTests),
        testCase(VoiceOverTests.allTests),
        testCase(RxSwiftTests.allTests),
    ]
}
#endif
