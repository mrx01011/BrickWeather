//
//  TemperatureLabel.swift
//  WeatherForecastBrick
//
//  Created by Vladyslav Nhuien on 23.10.2022.
//

import UIKit

class TemperatureLabel: UILabel {
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
        text = "0º"
        font = Constants.MainViewController.TemperatureLabel.font
        textColor = Constants.MainViewController.TemperatureLabel.textColor
    }
}
