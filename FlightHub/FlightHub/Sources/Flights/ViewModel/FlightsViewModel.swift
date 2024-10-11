//
//  FlightsViewModel.swift
//  FlightHub
//
//  Created by Bruno Moura on 08/10/24.
//

import Foundation

protocol FlightsViewModelProtocol: AnyObject {
    func searchText(content: [Flight])
    func updateData(content: [Flight])
    func errorLoadFlight(title: String, message: String)
    func filterFlights(content: [Flight])
}

final class FlightsViewModel {
    private let flightsService: FlightServiceProtocol
    private let flightsManager: FlightsManagerProtocol
    private weak var delegate: FlightsViewModelProtocol?
    
    private var isLoading: Bool = .init()
    public var searchText: String = "" {
        didSet {
            filterFlights()
        }
    }
    public var noResults: Bool {
        if flightsManager.filterFlights.isEmpty {
            return true
        } else {
            return false
        }
    }
    public var filterApplied: FlightStatus? {
        return flightsManager.filterApplied
    }
    
    init(flightsService: FlightServiceProtocol, flightsManager: FlightsManagerProtocol) {
        self.flightsService = flightsService
        self.flightsManager = flightsManager
    }
    
    deinit {
        print(Self.self, "- Deallocated")
    }
}

extension FlightsViewModel {
    // MARK: Assign delegate
    /**
     Assigns a delegate to handle updates from the view model.
     
     - Parameter delegate: The delegate conforming to `FlightsViewModelProtocol`.
     */
    public func delegate(delegate: FlightsViewModelProtocol?) {
        self.delegate = delegate
    }
    
    // MARK: Filter flights
    /**
     Filters flights based on the current search text.
     
     This function applies a search filter to the list of flights and notifies the delegate with the filtered content.
     */
    public func filterFlights() {
        flightsManager.searchFlights(searchText)
        delegate?.searchText(content: flightsManager.filterFlights)
    }
    
    // MARK: Load flight data
    /**
     Loads flight data asynchronously from the flight service.
     
     This function fetches flights from the service, saves them using the flight manager, and updates the view on completion.
     */
    public func loadFlightData() async {
        isLoading = true
        do {
            let flightsResponse = try await flightsService.fetchFlights()
            self.flightsManager.saveFlights(flightsResponse.flights)
            self.isLoading = false
        } catch {
            self.isLoading = false
            self.delegate?.errorLoadFlight(title: "flights.alert.error.title".localized,
                                           message: "flights.alert.error.message".localized)
            print("Failed to fetch flights: \(error.localizedDescription)")
        }
        
        await updateView()
    }
    
    // MARK: Update view
    /**
     Updates the view with the latest filtered flight data.
     
     This function ensures that the UI is updated on the main thread with the current list of filtered flights.
     */
    private func updateView() async {
        await MainActor.run { [weak self] in
            guard let self = self else { return }
            self.delegate?.updateData(content: flightsManager.filterFlights)
        }
    }
    
    // MARK: Filter flights by status
    /**
     Filters the list of flights based on their status.
     
     - Parameter filter: The flight status used to filter flights.
     */
    public func filterFlightsByStatus(_ filter: FlightStatus?) {
        flightsManager.filterFlightsByStatus(filter)
        checkNecessaryUpdateSearchAfterFilter()
        delegate?.filterFlights(content: flightsManager.filterFlights)
    }
    
    // MARK: Check necessary update after filter
    /**
     Checks if the search filter needs to be reapplied after filtering by status.
     
     This function ensures that the search text is re-applied to the filtered list of flights.
     */
    private func checkNecessaryUpdateSearchAfterFilter() {
        if !searchText.isEmpty {
            flightsManager.searchFlights(searchText)
        }
    }
    
    // MARK: Number of rows in section
    /**
     Returns the number of rows for the table view based on the filtered flights.
     
     - Returns: The number of filtered flights available for display in the table view.
     */
    public var numberOfRowsInSection: Int {
        return flightsManager.filterFlights.count
    }
}
