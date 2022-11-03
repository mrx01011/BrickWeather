//
//  WeatherManager.swift
//  WeatherForecastBrick
//
//  Created by Vladyslav Nhuien on 23.10.2022.
//

import Foundation

final class WeatherManager {
    private let queue = DispatchQueue(label: "WeatherManager_working_queue", qos: .userInitiated)
    
    func updateWeatherInfo(latitude: Double,
                           longtitude: Double,
                           completion: ((CompletionData) -> Void)?) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longtitude)&appid=b341573f7a5bb123a98e2addf28cba47&units=metric") else { return }
        queue.async {
            let task = URLSession.shared.dataTask(with: url) { data, responce, error in
                if let data = data, let weather = try? JSONDecoder().decode(WeatherData.self, from: data) {
                    DispatchQueue.main.async {
                        let completionData = CompletionData(
                            city: weather.name,
                            temperature: Int(weather.main.temp),
                            weather: weather.weather.first?.main ?? "",
                            id: weather.weather.first?.id ?? 0,
                            windSpeed: weather.wind.speed)
                        completion?(completionData)
                    }
                }
            }
            task.resume()
        }
    }
}
