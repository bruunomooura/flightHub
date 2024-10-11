//
//  Color+Extensions.swift
//  FlightHub
//
//  Created by Bruno Moura on 10/10/24.
//

import SwiftUI

public extension Color {
    static let backGround = Color(hex: "1C2133")
}

extension Color {
    // MARK: Initialize Color with Hex
     /**
      Initializes a `Color` using a hexadecimal string.
      
      This initializer parses a hexadecimal string and extracts the red, green, and blue components to create a `Color`.
      
      - Parameter hex: The hexadecimal string representing the color. It can optionally include a `#` at the beginning.
      */
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var hexNumber: UInt64 = 0
        scanner.scanHexInt64(&hexNumber)

        let r = Double((hexNumber & 0xFF0000) >> 16) / 255
        let g = Double((hexNumber & 0x00FF00) >> 8) / 255
        let b = Double(hexNumber & 0x0000FF) / 255

        self.init(red: r, green: g, blue: b)
    }
}
