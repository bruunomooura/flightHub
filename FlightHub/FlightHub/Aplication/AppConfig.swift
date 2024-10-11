//
//  AppConfig.swift
//  FlightHub
//
//  Created by Bruno Moura on 08/10/24.
//

import Foundation

final class AppConfig {
    static let currentDevelopmentStatus: DevelopmentStatus = {
#if DEBUG
        return .development
#else
        return .production
#endif
    }()
    
    static func flightsService() -> FlightServiceProtocol {
        print("Development Status:", currentDevelopmentStatus)
        switch currentDevelopmentStatus {
        case .development:
            return MockServiceManager()
        case .production:
            return MockServiceManager()
        }
    }
}
