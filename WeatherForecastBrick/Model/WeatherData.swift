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
    var speed: Double = 0.0
}

struct Main: Codable {
    var temp = 0.0
}

struct WeatherData: Codable {
    var name: String = ""
    var weather: [Weather] = []
    var main: Main = Main()
    var wind: Wind = Wind()
}

