//
//  FilterableProtocol.swift
//  FlightHub
//
//  Created by Bruno Moura on 10/10/24.
//

import Foundation

// MARK: FilterableProtocol
/**
 A protocol that defines the basic structure for filterable items.
 
 This protocol requires that conforming types have an `id`, `title`, and `icon`. It also conforms to `Identifiable`, `Hashable`, and `CustomStringConvertible`, ensuring that instances can be uniquely identified, hashed, and described as strings.
 
 Typical usage includes representing filterable data in user interfaces, where each item has a unique identifier, a title, and an associated icon.
 */
protocol FilterableProtocol: Identifiable, Hashable, CustomStringConvertible {
    var id: UUID { get }
    var title: String { get }
    var icon: String { get }
}

extension FilterableProtocol {
    var description: String {
        return description
    }
}
