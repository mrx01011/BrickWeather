//
//  TemperatureLabel.swift
//  WeatherForecastBrick
//
//  Created by Vladyslav Nhuien on 23.10.2022.
//

import UIKit
import SnapKit

final class WeatherView: UIView {
    var viewData: ViewData? {
        didSet {
            temperatureLabel.text = viewData?.temperature
            locationLabel.text = viewData?.city
            weatherLabel.text = viewData?.weather
        }
    }
    //MARK: UI Elements
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "99º"
        label.font = Constants.MainViewController.TemperatureLabel.font
        label.textColor = Constants.MainViewController.TemperatureLabel.textColor
        return label
    }()
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Hell"
        label.textColor = Constants.LocationLabel.textColor
        label.font = Constants.LocationLabel.font
        return label
    }()
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.MainViewController.TemperatureLabel.textColor
        label.font = Constants.MainViewController.WeatherLabel.font
        label.text = "Hot as hell"
        return label
    }()
    private let vectorIcon = UIImageView(image: UIImage(named: "icon_location.pdf"))
    private let searchIcon = UIImageView(image: UIImage(named: "icon_search.pdf"))
    //MARK: Inititalization
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    //MARK: Methods
    private func setupUI() {
        addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(Constants.OffSets.MainViewController.tempLabelTrailing)
        }
        addSubview(weatherLabel)
        weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(Constants.OffSets.MainViewController.weatherLabelTrailing)
        }
        addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherLabel.snp.bottom).offset(Constants.OffSets.MainViewController.locationViewTop)
        }
        addSubview(vectorIcon)
        vectorIcon.snp.makeConstraints { make in
            make.trailing.equalTo(locationLabel.snp.leading).offset(-Constants.OffSets.LocationView.horizontalSpacing)
            make.centerY.equalTo(locationLabel)
        }
        addSubview(searchIcon)
        searchIcon.snp.makeConstraints { make in
            make.leading.equalTo(locationLabel.snp.trailing).offset(Constants.OffSets.LocationView.horizontalSpacing)
            make.centerY.equalTo(locationLabel)
            make.bottom.equalToSuperview()
        }
    }
}


