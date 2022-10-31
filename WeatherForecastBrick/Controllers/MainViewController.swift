//
//  ViewController.swift
//  WeatherForecastBrick
//
//  Created by Vladyslav Nhuien on 23.10.2022.
//

import UIKit
import SnapKit
import CoreLocation

final class MainViewController: UIViewController {
    //MARK: Managers
    private let locationManager = CLLocationManager()
    private let weatherManager = WeatherManager()
    //MARK: InfoView Constraints
    private var constraintTop: ConstraintMakerFinalizable? = nil
    private var constraintWidth: ConstraintMakerFinalizable? = nil
    private var constraintHeight: ConstraintMakerFinalizable? = nil
    private var constraintCenterX: ConstraintMakerFinalizable? = nil
    private var constraintCenter: ConstraintMakerFinalizable? = nil
    //MARK: UIElements
    private let weatherView = WeatherView()
    private let infoButton = InfoButton()
    private let infoView = InfoView()
    private let brickImageView = BrickImageView()
    private let contentView = UIView()
    private let scrollView = UIScrollView()
    private let refreshControl = UIRefreshControl()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        defaultConfiguration()
        addTargets()
        startLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGradientBackground()
    }
    
    //MARK: Methods
    private func setupUI() {
        var topPadding: CGFloat
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            topPadding = window?.safeAreaInsets.top ?? 0
        } else {
            let window = UIApplication.shared.keyWindow
            topPadding = window?.safeAreaInsets.top ?? 0
        }
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-topPadding)
            make.leading.trailing.bottom.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.center.equalToSuperview()
        }
        //Weather view
        view.addSubview(weatherView)
        weatherView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.OffSets.MainViewController.leftSide)
        }
        //Info button
        view.addSubview(infoButton)
        infoButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.OffSets.MainViewController.InfoButton.height)
            make.width.equalTo(Constants.OffSets.MainViewController.InfoButton.width)
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherView.snp.bottom).offset(Constants.OffSets.MainViewController.InfoButton.top)
            make.bottom.equalTo(view.safeAreaInsets.bottom).offset(Constants.OffSets.MainViewController.InfoButton.bottom)
        }
        //Info view
        contentView.addSubview(infoView)
        infoView.snp.makeConstraints { make in
            constraintTop = make.top.equalTo(infoButton.snp.bottom).priority(.high)
            constraintWidth = make.width.equalTo(Constants.OffSets.MainViewController.InfoView.width).priority(.high)
            constraintCenterX = make.centerX.equalToSuperview().priority(.high)
            constraintHeight = make.height.equalTo(Constants.OffSets.MainViewController.InfoView.heigth).priority(.high)
            constraintCenter = make.center.equalToSuperview().priority(.low)
        }
        //Brick image view
        contentView.addSubview(brickImageView)
        brickImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Constants.OffSets.MainViewController.brickSide)
        }
    }
    
    private func defaultConfiguration() {
        infoView.delegate = self
        scrollView.refreshControl = refreshControl
    }
    
    private func addTargets() {
        infoButton.addTarget(self, action: #selector(showInfo), for: .touchUpInside)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    private func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [Constants.MainViewController.topGradientColor,
                                Constants.MainViewController.bottomGradientColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.transform = Constants.MainViewController.gradientTransform
        gradientLayer.frame = view.bounds.insetBy(dx: -0.5 * view.bounds.size.width, dy: -0.5 * view.bounds.size.height)
        gradientLayer.startPoint = Constants.MainViewController.gradientStartPoint
        gradientLayer.endPoint = Constants.MainViewController.gradientEndPoint
        
        self.scrollView.layer.insertSublayer(gradientLayer, at:0)
    }
    
    private func startLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
        }
    }
    
    @objc private func showInfo() {
        UIView.animate(withDuration: 1) {
            self.constraintTop?.constraint.update(priority: .low)
            self.constraintCenterX?.constraint.update(priority: .low)
            self.constraintCenter?.constraint.update(priority: .high)
            self.scrollView.layoutIfNeeded()
            self.infoButton.isHidden = true
            self.weatherView.isHidden = true
            self.brickImageView.isHidden = true
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        guard let location = locationManager.location else { return }
        weatherManager.updateWeatherInfo(latitude: location.coordinate.latitude, longtitude: location.coordinate.longitude) { [weak self] (city, temperature, weather, id, windSpeed) in
            guard let self = self else { return }
            self.weatherView.viewData?.weather = weather
            self.weatherView.viewData?.city = city
            self.weatherView.viewData?.temperature = String(temperature) + "º"
            self.brickImageView.brickState = .init(temperature: temperature, id: id, windSpeed: windSpeed)
        }
        refreshControl.endRefreshing()
    }
}
//MARK: Info view delegate
extension MainViewController: InfoViewDelegate {
    func hideInfo() {
        UIView.animate(withDuration: 1) {
            self.constraintTop?.constraint.update(priority: .high)
            self.constraintCenterX?.constraint.update(priority: .high)
            self.constraintCenter?.constraint.update(priority: .low)
            self.scrollView.layoutIfNeeded()
        } completion: { done in
            if done {
                self.infoButton.isHidden = false
                self.weatherView.isHidden = false
                self.brickImageView.isHidden = false
            }
        }
    }
}

//MARK: Location manager delegate
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        weatherManager.updateWeatherInfo(latitude: lastLocation.coordinate.latitude, longtitude: lastLocation.coordinate.longitude) { [weak self] (city, temperature, weather, id, windSpeed) in
            guard let self = self else { return }
            let viewData = ViewData(temperature: String(temperature) + "º", city: city, weather: weather)
            self.weatherView.viewData = viewData
            self.brickImageView.brickState = .init(temperature: temperature, id: id, windSpeed: windSpeed)
        }
    }
}



