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
    
    func testLabelRxUpdateSource() {
        let mockSource = BehaviorRelay<String>(value: "New Text")
        
        let label = Label("Cell One")
                .bind(source: mockSource)
        
        assert(label.text == "New Text")
        
        mockSource.accept("This is New Text!")
        
        assert(label.text == "This is New Text!")
    }
    
    func testLabelRxUpdateSourceConvenienceInit() {
        let mockSource = BehaviorRelay<String>(value: "")
        
        let label = Label(source: mockSource)
        
        mockSource.accept("This is just one of three views!")
        
        assert(label.text == "This is just one of three views!")
    }
    
    static var allTests = [
        ("testTableRxUpdateSource", testTableRxUpdateSource),
        ("testTableRxUpdateSourceConvenienceInit", testTableRxUpdateSourceConvenienceInit),
        ("testLabelRxUpdateSource", testLabelRxUpdateSource),
        ("testLabelRxUpdateSourceConvenienceInit", testLabelRxUpdateSourceConvenienceInit)
    ]
}
