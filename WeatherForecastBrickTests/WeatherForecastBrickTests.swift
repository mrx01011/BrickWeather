//
//  WeatherForecastBrickTests.swift
//  WeatherForecastBrickTests
//
//  Created by Vladyslav Nhuien on 23.10.2022.
//

import XCTest
@testable import WeatherForecastBrick

final class WeatherForecastBrickTests: XCTestCase {
    
    var urlSession: URLSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
    }
    
    func testGetWeather() throws {
        
    }
}
