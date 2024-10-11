//
//  MockServiceManager.swift
//  FlightHub
//
//  Created by Bruno Moura on 08/10/24.
//

import Foundation

final class MockServiceManager: FlightServiceProtocol {
    
    private let decoderService: JSONDecoderService
    
    init(decoderService: JSONDecoderService = JSONDecoderService()) {
        self.decoderService = decoderService
    }
    
    func fetchFlights() async throws -> FlightResponse {
        guard let url = Bundle.main.url(forResource: JSONFile.flightsData.rawValue, withExtension: JSONFile.json.rawValue) else { throw FlightsLoadingError.errorReceivingData
        }
        
        do {
            let data = try Data(contentsOf: url)
            let flights: FlightResponse = try decoderService.decode(FlightResponse.self, from: data)
            
            return flights
        } catch {
            print("Error: \(error.localizedDescription)")
            throw error
        }
    }
}
