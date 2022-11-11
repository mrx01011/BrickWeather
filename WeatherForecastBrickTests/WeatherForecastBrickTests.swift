//
//  WeatherForecastBrickTests.swift
//  WeatherForecastBrickTests
//
//  Created by Vladyslav Nhuien on 23.10.2022.
//

import XCTest
@testable import WeatherForecastBrick

final class WeatherForecastBrickTests: XCTestCase {
    
    var weatherManager: WeatherManager!
    var brickImageView: BrickImageView!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        weatherManager = WeatherManager()
        brickImageView = BrickImageView()
    }
    
    override func tearDownWithError() throws {
        weatherManager = nil
        brickImageView = nil
        try super.tearDownWithError()
    }
    
    func testGetWeather() throws {
        let latitude = 49.98
        let longtitude = 36.24
        var cod: Int = 0
        weatherManager.updateWeatherInfo(latitude: latitude, longtitude: longtitude) { completionData in
            cod = completionData.cod
            XCTAssertEqual(cod, 200)
        }
    }
    
    func testParsingData() throws {
        let state: BrickImageView.BrickState = .hot(windy: false)
        let mockData = CompletionData(city: "Mumbai", temperature: 31, weather: "sunny", id: 100, windSpeed: 2.0, cod: 200)
        
        brickImageView.brickState = .init(temperature: mockData.temperature, id: mockData.id, windSpeed: mockData.windSpeed)
        
        XCTAssertEqual(state, brickImageView.brickState)
    }
}
