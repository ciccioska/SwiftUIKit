//
//  Observe.swift
//  
//
//  Created by Zach Eriksen on 11/5/19.
//

import UIKit


class Observe {
    public static var shared = Observe()
    
    private var bag: [UIView: [NSKeyValueObservation]] = [:]
    
    public func add(observation: NSKeyValueObservation, forView view: UIView) {
        guard var observations = bag[view] else {
            bag[view] = [observation]
            return
        }
        observations.append(observation)
    }
    
    public func add(observations: [NSKeyValueObservation], forView view: UIView) {
        observations.forEach {
            add(observation: $0, forView: view)
        }
    }
    
    public func remove(observation: NSKeyValueObservation, forView view: UIView) {
        guard var observations = bag[view] else {
            bag[view] = [observation]
            return
        }
        observations.removeAll { $0 == observation }
    }
    
    public func remove(observations: [NSKeyValueObservation], forView view: UIView) {
        observations.forEach {
            remove(observation: $0, forView: view)
        }
    }
    
    public func removeAllObservations(forView view: UIView) {
        bag[view] = nil
    }
}

public extension UIView {
    func add(observation: NSKeyValueObservation) {
        Observe.shared.add(observation: observation, forView: self)
    }
    
    func add(observations: [NSKeyValueObservation]) {
        Observe.shared.add(observations: observations, forView: self)
    }
    
    func remove(observation: NSKeyValueObservation) {
        Observe.shared.remove(observation: observation, forView: self)
    }
    
    func remove(observations: [NSKeyValueObservation]) {
        Observe.shared.remove(observations: observations, forView: self)
    }
    
    func removeAllObservations() {
        Observe.shared.removeAllObservations(forView: self)
    }
}
