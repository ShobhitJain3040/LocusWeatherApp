//
//  Box.swift
//  WeatherAppLocus
//
//  Created by Shobhit Jain on 12/03/22.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
