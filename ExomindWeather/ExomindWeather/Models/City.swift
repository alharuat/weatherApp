//
//  City.swift
//  ExomindWeather
//
//  Created by Samir on 4/3/23.
//

import Foundation
struct City: Decodable {
    let coord: Coordinate
    let country, name: String
    var current:Current?
}
struct Coordinate: Decodable {
    let lat, lon: Double
}
