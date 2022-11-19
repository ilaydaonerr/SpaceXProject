//
//  URLService.swift
//  MobilliumCase
//
//  Created by İlayda Öner on 19.11.2022.
//

import Foundation

enum FlightServiceEndpoint: String {
    case BASE_URL = "https://api.spacexdata.com/v4/launches"
    case PAST = "/past"
    case UPCOMING = "/upcoming"
    
    static func pastUrlPath() -> URL {
        return URL(string: "\(BASE_URL.rawValue)\(PAST.rawValue)")!
    }
    
    static func upcomingUrlPath() -> URL {
        return URL(string: "\(BASE_URL.rawValue)\(UPCOMING.rawValue)")!
    }
}

