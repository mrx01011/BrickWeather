//
//  WeatherData.swift
//  WeatherForecastBrick
//
//  Created by Vladyslav Nhuien on 23.10.2022.
//

import Foundation

struct Weather: Codable {
    var id: Int
    var main: String
}

struct Wind: Codable {
    var speed: Double
}

struct Main: Codable {
    var temp: Double
}

struct WeatherData: Codable {
    var name: String
    var weather: [Weather]
    var main: Main
    var wind: Wind
}

