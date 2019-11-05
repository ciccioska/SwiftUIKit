//
//  File.swift
//  
//
//  Created by Zach Eriksen on 11/4/19.
//

import Foundation
import XCTest
import RxSwift
import RxRelay
@testable import SwiftUIKit

@available(iOS 9.0, *)
final class RxSwiftTests: XCTestCase {
    
    func testTableRxUpdateSource() {
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
    
    func testTableRxUpdateSourceConvenienceInit() {
        let mockSource = BehaviorRelay<[UIView]>(value: [])
        
        let table = Table(source: mockSource)
        
        mockSource.accept([Label("This is just one of three views!"),
                           Label("This is just one of three views!"),
                           Label("This is just one of three views!")])
        
        assert(table.currentData.count == 3)
    }
    
    static var allTests = [
        ("testTableRxUpdateSource", testTableRxUpdateSource),
        ("testTableRxUpdateSourceConvenienceInit", testTableRxUpdateSourceConvenienceInit)
    ]
}
