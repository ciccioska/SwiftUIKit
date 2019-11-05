//
//  BehaviorRelay+SwiftUIKit.swift
//  
//
//  Created by Zach Eriksen on 11/4/19.
//

import RxSwift
import RxRelay

public extension BehaviorRelay where Element: RangeReplaceableCollection {
    func append(_ element: Element.Element) {
        accept(value + [element])
    }
}
