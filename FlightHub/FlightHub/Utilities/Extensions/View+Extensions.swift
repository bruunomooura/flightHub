//
//  View+Extensions.swift
//  FlightHub
//
//  Created by Bruno Moura on 10/10/24.
//

import SwiftUI

public extension View {
    // MARK: - Custom Stroke Modifier
    /**
     A view modifier that applies a stroke (border) to a view, with various shape options.
     
     This modifier allows you to apply a stroke with customizable color, stroke type, line width, and corner radius, giving flexibility to define borders for different shapes such as circles, rectangles, rounded rectangles, and ellipses.
     
     - Parameters:
        - color: The color of the stroke. The default value is `.backGround`.
        - type: The shape of the stroke, specified by the `StrokeType` enum. The default value is `.roundedRectangle`.
        - lineWidth: The width of the stroke line. The default value is `1`.
        - radius: The corner radius for the rounded rectangle. The default value is `16`. This parameter is only used when `type` is `.roundedRectangle`.
     
     - Returns: A view with the specified stroke applied.
     */
    @ViewBuilder
    func stroke(
        color: Color = .backGround,
        type: StrokeType = .roundedRectangle,
        lineWidth: CGFloat = 1,
        radius: CGFloat = 16) -> some View {
        
        switch type {
        case .circle:
            background(color, in: .circle
                .stroke(style: .init(lineWidth: lineWidth)))
        case .roundedRectangle:
            background(color, in: .rect(cornerRadius: radius)
                .stroke(style: .init(lineWidth: lineWidth)))
        case .rectangle:
            background(color, in: .rect
                .stroke(style: .init(lineWidth: lineWidth)))
        case .ellipse:
            background(color, in: .ellipse
                .stroke(style: .init(lineWidth: lineWidth)))
        }
    }
}
