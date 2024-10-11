//
//  FlightsManager.swift
//  FlightHub
//
//  Created by Bruno Moura on 09/10/24.
//

import Foundation

protocol FlightsManagerProtocol: AnyObject {
    var listFlights: [Flight] { get }
    var filterFlights: [Flight] { get }
    var filterApplied: FlightStatus? { get }
    func searchFlights(_ searchText: String)
    func saveFlights(_ movies: [Flight])
    func filterFlightsByStatus(_ filter: FlightStatus?)
}

final class FlightsManager: FlightsManagerProtocol {
    var listFlights: [Flight] = []
    var filterFlights: [Flight] = []
    var filterApplied: FlightStatus?
    
    func searchFlights(_ searchText: String) {
        
        filterFlights = listFlights
        
        // Apply the status filter, if any
        if let filterApplied = filterApplied {
            filterFlights = filterFlights.filter { $0.status == filterApplied }
        }
        
        // Apply the search filter, if the search text is not empty
        if !searchText.isEmpty {
            filterFlights = filterFlights.filter { $0.flightID.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func saveFlights(_ movies: [Flight]) {
        listFlights = movies
        filterFlights = listFlights
    }
    
    func filterFlightsByStatus(_ filter: FlightStatus?) {
        filterApplied = filter
        switch filter {
        case .upcoming, .canceled, .completed, .inFlight:
            filterFlights = listFlights.filter { $0.status == filter }
        case nil:
            filterFlights = listFlights
        }
    }
}
