//
//  ViewCode.swift
//  FlightHub
//
//  Created by Bruno Moura on 08/10/24.
//

import Foundation

/**
 A protocol that defines the basic structure for implementing view setup in a programmatic UI (ViewCode).
 
 Conforming to this protocol ensures that views are set up with a consistent structure, including the addition of subviews, application of layout constraints, and styling.
 
 The default implementation provides a `setup()` method that calls the required methods in the proper order: `addSubviews()`, `setupConstraints()`, and `setupStyle()`.
 */
protocol ViewCode {
    func addSubviews()
    func setupConstraints()
    func setupStyle()
}

extension ViewCode {
    func setup() {
        addSubviews()
        setupConstraints()
        setupStyle()
    }
}
