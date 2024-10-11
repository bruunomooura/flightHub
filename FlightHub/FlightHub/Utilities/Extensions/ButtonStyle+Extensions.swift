//
//  ButtonStyle+Extensions.swift
//  FlightHub
//
//  Created by Bruno Moura on 10/10/24.
//

import SwiftUI

public enum ButtonSize {
    /// size  =  50pt
    case large
    /// size =  40pt
    case normal
    /// size = 30px
    case small
    
    /// button Height
    var heigh: CGFloat {
        switch self {
        case .large:
            return 50
        case .normal:
            return 40
        case .small:
            return 30
        }
    }
}

// MARK: - Custom Button Style
/**
 A custom button style that adjusts the button's appearance based on its size and color.
 
 This style also adds a scaling effect when the button is pressed.
 
 - Parameters:
    - size: The size of the button as defined by the `ButtonSize` enum.
    - color: The background color of the button.
 */
struct CustomButtonStyle: ButtonStyle {
    @State private var scale: CGFloat = 0.95
    let size: ButtonSize
    let color: Color
    
    // MARK: - Create Button Body
      /**
       Creates the body of the button, applying its size, background color, and scaling effect.
       
       - Parameter configuration: A structure containing the configuration for the button's label and whether it is pressed.
       
       - Returns: A view representing the button's body.
       */
    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: size.heigh)
            .background(color, in: .rect(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? scale : 1)
    }
}

// MARK: - Custom Stroke Button Style
/**
 A custom button style that adds a stroke around the button's label instead of a filled background.
 
 This style also adds a scaling effect when the button is pressed.
 
 - Parameters:
    - size: The size of the button as defined by the `ButtonSize` enum.
    - color: The color of the stroke.
 */
struct CustomStrokeButtonStyle: ButtonStyle {
    @State private var scale: CGFloat = 0.95
    let size: ButtonSize
    let color: Color
    
    // MARK: - Create Button Body
       /**
        Creates the body of the button, applying its size, stroke color, and scaling effect.
        
        - Parameter configuration: A structure containing the configuration for the button's label and whether it is pressed.
        
        - Returns: A view representing the button's body with a stroke around it.
        */
    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: size.heigh)
            .stroke(color: color, radius: 10)
            .background(.background.opacity(0.0001))
            .scaleEffect(configuration.isPressed ? scale : 1)
    }
}

// MARK: - Custom Button Style Extensions
/**
 Adds a custom button style extension that includes a scaling effect.
 
 - Parameters:
    - size: The size of the button, default is `.large`.
    - color: The color of the button, default is `.background`.
 
 - Returns: A `CustomButtonStyle` instance.
 */
extension ButtonStyle where Self == CustomButtonStyle {
    /// `CustomButtonStyle` adds a scalling effect triggered by the is Pressed Bollean
    static func custom(size: ButtonSize = .large, color: Color = .background) -> CustomButtonStyle {
        return CustomButtonStyle(size: size, color: color)
    }
}

// MARK: - Custom Stroke Button Style Extensions
/**
 Adds a custom stroke button style extension that adds a stroke around the button's label.
 
 - Parameters:
    - size: The size of the button, default is `.large`.
    - color: The stroke color, default is `.backGround`.
 
 - Returns: A `CustomStrokeButtonStyle` instance.
 */
extension ButtonStyle where Self == CustomStrokeButtonStyle {
    /// `CustomStrokeButtonStyle` add a stroke around the button Label
    static func stroke(size: ButtonSize = .large, color: Color = .backGround) -> CustomStrokeButtonStyle {
        return CustomStrokeButtonStyle(size: size, color: color)
    }
}

// MARK: - Stroke Type Enum
/**
 An enumeration representing different stroke types for shapes.
 
 This enum provides four stroke options for various shape types.
 
 - Cases:
    - circle: A stroke that forms a circle.
    - roundedRectangle: A stroke that forms a rounded rectangle.
    - rectangle: A stroke that forms a rectangle.
    - ellipse: A stroke that forms an ellipse.
 */
public enum StrokeType {
    /// Creates a circle shape stroke
    case circle
    /// Creates a rounded rectangle shape stroke
    case roundedRectangle
    /// Creates a  rectangle shape stroke
    case rectangle
    /// Creates a ellipse shape stroke
    case ellipse
}
