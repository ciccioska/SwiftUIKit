//
//  UIView+Builder.swift
//  SwiftUIKit
//
//  Created by Zach Eriksen on 1/28/20.
//

import UIKit

@_functionBuilder
public struct UIViewBuilder {
    
    public static func buildBlock(_ view: UIView) -> UIView {
        view
    }
    
    public static func buildBlock(_ views: UIView...) -> [UIView] {
        views
    }
}
