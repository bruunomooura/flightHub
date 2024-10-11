//
//  String+Extensions.swift
//  FlightHub
//
//  Created by Bruno Moura on 08/10/24.
//

import Foundation

extension String {
    // MARK: Localized
    /// Just calling this variable to any string you can obtain its localized version.
    /// Arguments can be applied using the same SwiftUI Text() format:
    ///     "key \(argument)".localized
    var localized: String {
        if let index = self.firstIndex(of: " ") {
            let key = self.prefix(upTo: index)
            var parameter = self.suffix(from: index)
            parameter.removeFirst()
            return String(format: NSLocalizedString("\(key) %@", comment: ""), String(parameter))
        } else {
            return String(localized: LocalizationValue(self))
        }
    }
    
    // MARK: Formatted date
        /// Returns the date formatted from "yyyy-MM-dd" to "dd/MM/yyyy".
        /// Returns the original string if conversion fails.
    var formattedDate: String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yyyy"
        
        if let date = inputFormatter.date(from: self) {
            return outputFormatter.string(from: date)
        }
        return self
    }
    
}
