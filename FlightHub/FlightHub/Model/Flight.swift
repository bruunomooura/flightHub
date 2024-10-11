//
//  Flight.swift
//  FlightHub
//
//  Created by Bruno Moura on 08/10/24.
//

import Foundation

// MARK: - Flights
struct FlightResponse: Decodable {
    let flights: [Flight]
}

// MARK: - Flight
struct Flight {
    let flightID: String
    let status: FlightStatus
    let completionStatus: CompletionStatus
    let startDate: String
    let endDate: String
    let departureTime: String
    let arrivalTime: String
    let departureAirport: String
    let arrivalAirport: String
    let airplaneName: String
    
    // MARK: Init
    init(flightID: String = .init(),
         status: FlightStatus = .canceled,
         completionStatus: CompletionStatus = .canceled,
         startDate: String = .init(),
         endDate: String = .init(),
         departureTime: String = .init(),
         arrivalTime: String = .init(),
         departureAirport: String = .init(),
         arrivalAirport: String = .init(),
         airplaneName: String = .init()
    ) {
        self.flightID = flightID
        self.status = status
        self.completionStatus = completionStatus
        self.startDate = startDate
        self.endDate = endDate
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.departureAirport = departureAirport
        self.arrivalAirport = arrivalAirport
        self.airplaneName = airplaneName
    }
}

extension Flight: Decodable {
    
    // MARK: CodingKeys
    enum CodingKeys: String, CodingKey {
        case flightID = "flight_id"
        case status
        case completionStatus = "completion_status"
        case startDate = "start_date"
        case endDate = "end_date"
        case departureTime = "departure_time"
        case arrivalTime = "arrival_time"
        case departureAirport = "departure_airport"
        case arrivalAirport = "arrival_airport"
        case airplaneName = "airplane_name"
    }
    
    // MARK: Decode If Present
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.flightID = try values.decodeIfPresent(String.self, forKey: .flightID) ?? .init()
        self.status = try values.decodeIfPresent(FlightStatus.self, forKey: .status) ?? .canceled
        self.completionStatus = try values.decodeIfPresent(CompletionStatus.self, forKey: .completionStatus) ?? .canceled
        self.startDate = try values.decodeIfPresent(String.self, forKey: .startDate) ?? .init()
        self.endDate = try values.decodeIfPresent(String.self, forKey: .endDate) ?? .init()
        self.departureTime = try values.decodeIfPresent(String.self, forKey: .departureTime) ?? .init()
        self.arrivalTime = try values.decodeIfPresent(String.self, forKey: .arrivalTime) ?? .init()
        self.departureAirport = try values.decodeIfPresent(String.self, forKey: .departureAirport) ?? .init()
        self.arrivalAirport = try values.decodeIfPresent(String.self, forKey: .arrivalAirport) ?? .init()
        self.airplaneName = try values.decodeIfPresent(String.self, forKey: .airplaneName) ?? .init()
    }
}

enum CompletionStatus: String, Decodable {
    case delayed = "ATRASOU"
    case canceled = "CANCELADO"
    case onTime = "NO_HORARIO"
    
    var description: String {
        switch self {
        case .delayed:
            return "flightCompletionStatus.delayed".localized
        case .canceled:
            return "flightCompletionStatus.canceled".localized
        case .onTime:
            return "flightCompletionStatus.onTime".localized
        }
    }
}

enum FlightStatus: String, Decodable, FilterableProtocol, CaseIterable {
    case upcoming = "A REALIZAR"
    case canceled = "CANCELADO"
    case completed = "CONCLUIDO"
    case inFlight = "EM VIAGEM"
        
    var id: UUID { UUID() }
    var description: String {
        switch self {
        case .upcoming:
            return "flightStatus.upcoming".localized
        case .canceled:
            return "flightStatus.canceled".localized
        case .completed:
            return "flightStatus.completed".localized
        case .inFlight:
            return "flightStatus.inFlight".localized
        }
    }
    
    var icon: String {
        switch self {
        case .upcoming:
            return "calendar.badge.clock"
        case .canceled:
            return "xmark.circle.fill"
        case .completed:
            return "checkmark.circle"
        case .inFlight:
            return "airplane.circle.fill"
        }
    }
    
    var title: String {
        switch self {
        case .upcoming:
            return "flightStatus.title.upcoming".localized
        case .canceled:
            return "flightStatus.title.canceled".localized
        case .completed:
            return "flightStatus.title.completed".localized
        case .inFlight:
            return "flightStatus.title.inFlight".localized
        }
    }
}
