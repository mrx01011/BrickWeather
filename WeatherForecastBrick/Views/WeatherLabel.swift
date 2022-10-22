//
//  WeatherLabel.swift
//  WeatherForecastBrick
//
//  Created by Vladyslav Nhuien on 23.10.2022.
//

import UIKit

class WeatherLabel: UILabel {
    //MARK: Inititalization
    init() {
        super.init(frame: .zero)
        defaultConfiguration()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    //MARK: Methods
    private func defaultConfiguration() {
        text = "sunny"
        font = Constants.MainViewController.WeatherLabel.font
        textColor = Constants.MainViewController.TemperatureLabel.textColor
    }
}
