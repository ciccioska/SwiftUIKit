//
//  UIView+SwiftUIKit.swift
//  SwiftUIKit
//
//  Created by Zach Eriksen on 10/29/19.
//  Copyright © 2019 oneleif. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
public extension UIView {
    @discardableResult
    func stack(withSpacing spacing: Float = 0,
               padding: Float = 0,
               alignment: UIStackView.Alignment = .fill,
               distribution: UIStackView.Distribution = .fill,
               axis: NSLayoutConstraint.Axis,
               closure: () -> [UIView]) -> Self {
        let viewsInVStack = closure()
        
        let stackView = UIStackView(arrangedSubviews: viewsInVStack)
        stackView.spacing = CGFloat(spacing)
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.axis = axis
        
        embed(withPadding: padding) {
            stackView
        }
        
        return self
    }
    
    @discardableResult
    func vstack(withSpacing spacing: Float = 0,
                padding: Float = 0,
                alignment: UIStackView.Alignment = .fill,
                distribution: UIStackView.Distribution = .fill,
                closure: () -> [UIView]) -> Self {
        return stack(withSpacing: spacing,
                     padding: padding,
                     alignment: alignment,
                     distribution: distribution,
                     axis: .vertical,
                     closure: closure)
    }
    
    @discardableResult
    func hstack(withSpacing spacing: Float = 0,
                padding: Float = 0,
                alignment: UIStackView.Alignment = .fill,
                distribution: UIStackView.Distribution = .fill,
                closure: () -> [UIView]) -> Self {
        return stack(withSpacing: spacing,
                     padding: padding,
                     alignment: alignment,
                     distribution: distribution,
                     axis: .horizontal,
                     closure: closure)
    }
    
    @discardableResult
    func embed(withPadding padding: Float = 0,
               closure: () -> UIView) -> Self {
        let viewToEmbed = closure()
        viewToEmbed.translatesAutoresizingMaskIntoConstraints = false
        addSubview(viewToEmbed)
        
        NSLayoutConstraint.activate([
            viewToEmbed.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat(padding)),
            viewToEmbed.bottomAnchor.constraint(equalTo: bottomAnchor, constant: CGFloat(-padding)),
            viewToEmbed.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(padding)),
            viewToEmbed.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat(-padding))
        ])
        
        return self
    }
    
    @available(iOS 11.0, *)
    @discardableResult
    func safeArea(withPadding padding: Float = 0) -> Self {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: CGFloat(padding)),
            bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: CGFloat(-padding)),
            leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: CGFloat(padding)),
            trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: CGFloat(-padding))
        ])
        return self
    }
    
    @discardableResult
    func padding(_ padding: Float = 8) -> View {
        return View(backgroundColor: backgroundColor)
            .embed(withPadding: padding) { self }
            .accessibility(label: accessibilityLabel,
                           identifier: accessibilityIdentifier,
                           traits: accessibilityTraits)
    }
    
    @discardableResult
    func frame(height: Float? = nil, width: Float? = nil) -> Self {
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
        }
        
        return self
    }
    
    @discardableResult
    func layer(_ closure: (CALayer) -> Void) -> Self {
        closure(layer)
        
        return self
    }
    
    @discardableResult
    func accessibility(label: String? = nil,
                       identifier: String? = nil,
                       traits: UIAccessibilityTraits? = nil) -> Self {
        
        label.map { accessibilityLabel = $0 }
        identifier.map { accessibilityIdentifier = $0 }
        traits.map { accessibilityTraits = $0 }
        
        return self
    }
}

public extension UIView {
    @discardableResult
    func debug() -> Self {
        var randomColor: UIColor {
            return UIColor(red: CGFloat.random(in: 0 ... 255) / 255,
                           green: CGFloat.random(in: 0 ... 255) / 255,
                           blue: CGFloat.random(in: 0 ... 255) / 255,
                           alpha: 1)
        }
        func getSubViews(forView view: UIView) -> [UIView] {
            var views: [UIView] = []
            for view in view.subviews {
                views.append(view)
                views.append(contentsOf: getSubViews(forView: view))
            }
            return views
        }
        let subviews = getSubViews(forView: self)
        
        print("DEBUG LOG:")
        print("Root Debug View: \(self)")
        print("Number of Views: \(subviews.count + 1)")
        
        subviews.forEach {
            $0.backgroundColor = randomColor
        }
        
        return self
    }
}

