//
//  WeatherResponse.swift
//  ExomindWeather
//
//  Created by Samir on 4/3/23.
//

import Foundation
struct WeatherResponse: Decodable {
    let current: Current
    let daily: [Daily]
}

struct Current: Decodable {
    let weather: [Weather]
    let temp, windSpeed: Double
    let humidity:Int
    let pressure:Int
    let windDeg :Double
}
struct Weather: Decodable {
    let icon: String
    let main: String
    let description:String
}

struct Daily: Decodable {
    let weather: [Weather]
    let humidity:Int
    let pressure:Int
    let windSpeed:Double
    let windDeg :Double
    let temp:Temperature
}

struct Temperature: Decodable {
    let day:Double
    let min :Double
    let max :Double
    let night :Double
    let eve :Double
    let morn :Double
}
