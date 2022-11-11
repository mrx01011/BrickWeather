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
        label.font = Constants.TemperatureLabel.font
        label.textColor = Constants.TemperatureLabel.textColor
        return label
    }()
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.LocationLabel.textColor
        label.font = Constants.LocationLabel.font
        return label
    }()
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.TemperatureLabel.textColor
        label.font = Constants.WeatherLabel.font
        return label
    }()
    private let vectorImageView = UIImageView(image: UIImage(named: "icon_location.pdf"))
    private let searchImageView = UIImageView(image: UIImage(named: "icon_search.pdf"))
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
            make.trailing.equalToSuperview().offset(Constants.Offsets.tempLabelTrailing)
        }
        addSubview(weatherLabel)
        weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(Constants.Offsets.weatherLabelTrailing)
        }
        addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherLabel.snp.bottom).offset(Constants.Offsets.locationViewTop)
        }
        addSubview(vectorImageView)
        vectorImageView.snp.makeConstraints { make in
            make.trailing.equalTo(locationLabel.snp.leading).offset(-Constants.Offsets.locationViewHorizontalSpacing)
            make.centerY.equalTo(locationLabel)
        }
        addSubview(searchImageView)
        searchImageView.snp.makeConstraints { make in
            make.leading.equalTo(locationLabel.snp.trailing).offset(Constants.Offsets.locationViewHorizontalSpacing)
            make.centerY.equalTo(locationLabel)
            make.bottom.equalToSuperview()
        }
    }
}
//MARK: Constants
extension WeatherView {
    enum Constants {
        enum TemperatureLabel {
            static let font = UIFont(name: "SFProDisplay-Semibold", size: 83) ?? UIFont.systemFont(ofSize: 83)
            static let textColor = UIColor(red: 0.175, green: 0.175, blue: 0.175, alpha: 1)
        }
        enum WeatherLabel {
            static let font = UIFont(name: "SFProDisplay-Light", size: 36) ?? UIFont.systemFont(ofSize: 36)
            static let textColor = UIColor(red: 0.175, green: 0.175, blue: 0.175, alpha: 1)
        }
        enum LocationLabel {
            static let textColor = UIColor(red: 0.175, green: 0.175, blue: 0.175, alpha: 1)
            static let font = UIFont(name: "SFProDisplay-Light", size: 17) ?? UIFont.systemFont(ofSize: 17)
        }
        enum Offsets {
            static let tempLabelTrailing: CGFloat = 235
            static let weatherLabelTrailing: CGFloat = 266
            static let locationViewTop: CGFloat = 83
            static let locationViewHorizontalSpacing: CGFloat = 5
        }
    }
}
