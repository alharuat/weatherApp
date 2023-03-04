//
//  Config.swift
//  ExomindWeather
//
//  Created by Samir on 4/3/23.
//

import Foundation
struct Defaults {
    static let Latitude: Double = 33.592781
    static let Longitude: Double = -7.61916
    static let daysCount : Int = 5
}

struct Config {
    // MARK: - Properties
    static let apiKey = "99778f189f239059899e125db87af0d0"
    static let baseUrl = "https://api.openweathermap.org/data/2.5/onecall"
}
