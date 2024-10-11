//
//  FlightServiceProtocol.swift
//  FlightHub
//
//  Created by Bruno Moura on 08/10/24.
//

import Foundation

// MARK: FlightServiceProtocol
/**
 A protocol that defines the contract for fetching flight data, supporting both mock and real API implementations.
 
 This protocol helps to conform flight search functionality to the SOLID principles, specifically the Dependency Inversion Principle (DIP). By abstracting the flight-fetching mechanism, it allows for flexible implementation, whether fetching flights from a mock source for testing or from a real API for production use.
 */
protocol FlightServiceProtocol {
    func fetchFlights() async throws -> FlightResponse
}
