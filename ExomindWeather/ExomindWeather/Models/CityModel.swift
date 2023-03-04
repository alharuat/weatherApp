//
//  CityModel.swift
//  ExomindWeather
//
//  Created by Samir on 4/3/23.
//

import Foundation
class CityObject  {
    var country: String = ""
    var name : String = ""
    var coordinate : CoordinateObject = CoordinateObject()
    var current : CurrentObject = CurrentObject()
    var daily: [DailyObject] = []
    
}

class CoordinateObject {
    var lat: Double = 0.0
    var lon : Double = 0.0
}


class CurrentObject {
    var temp: Double = 0.0
    var windSpeed: Double = 0.0
    var humidity:Int = 0
    var pressure:Int = 0
    var windDeg :Double = 0.0
    var weather: [WeatherObject] = []
}

class WeatherObject {
    var icon: String = ""
    var main: String = ""
}

class DailyObject {
    var weather: [WeatherObject] = []
    var humidity:Int = 0
    var pressure:Int = 0
    var windSpeed:Double = 0.0
    var windDeg :Double = 0.0
    var temp :Double = 0.0
}

class TemperatureObject {
    var day:Double = 0.0
    var min :Double = 0.0
    var max :Double = 0.0
    var night :Double = 0.0
    var eve :Double = 0.0
    var morn :Double = 0.0
}
