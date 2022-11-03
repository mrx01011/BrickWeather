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
    private var constraintTop: Constraint?
    private var constraintWidth: Constraint?
    private var constraintHeight: Constraint?
    private var constraintCenterX: Constraint?
    private var constraintCenter: Constraint?
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-(topPadding * 2))
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
            make.leading.trailing.equalToSuperview().inset(Constants.Offsets.leftSide)
        }
        //Info button
        view.addSubview(infoButton)
        infoButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.Offsets.InfoButton.height)
            make.width.equalTo(Constants.Offsets.InfoButton.width)
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherView.snp.bottom).offset(Constants.Offsets.InfoButton.top)
            make.bottom.equalTo(view.safeAreaInsets.bottom).offset(Constants.Offsets.InfoButton.bottom)
        }
        //Info view
        contentView.addSubview(infoView)
        infoView.snp.makeConstraints { make in
            constraintTop = make.top.equalTo(infoButton.snp.bottom).priority(.high).constraint
            constraintWidth = make.width.equalTo(Constants.Offsets.InfoView.width).priority(.high).constraint
            constraintCenterX = make.centerX.equalToSuperview().priority(.high).constraint
            constraintHeight = make.height.equalTo(Constants.Offsets.InfoView.heigth).priority(.high).constraint
            constraintCenter = make.center.equalToSuperview().priority(.low).constraint
        }
        //Brick image view
        contentView.addSubview(brickImageView)
        brickImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Constants.Offsets.brickSide)
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
        gradientLayer.colors = [Constants.topGradientColor,
                                Constants.bottomGradientColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.transform = Constants.gradientTransform
        gradientLayer.frame = view.bounds.insetBy(dx: -0.5 * view.bounds.size.width, dy: -0.5 * view.bounds.size.height)
        gradientLayer.startPoint = Constants.gradientStartPoint
        gradientLayer.endPoint = Constants.gradientEndPoint
        
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
    
    private func updateData(_ data: CompletionData) {
        let viewData = ViewData(temperature: String(data.temperature) + "º", city: data.city, weather: data.weather)
        self.weatherView.viewData = viewData
        self.brickImageView.brickState = .init(temperature: data.temperature, id: data.id, windSpeed: data.windSpeed)
    }
    
    @objc private func showInfo() {
        self.constraintTop?.update(priority: .low)
        self.constraintCenterX?.update(priority: .low)
        self.constraintCenter?.update(priority: .high)
        self.infoButton.isHidden = true
        self.weatherView.isHidden = true
        self.brickImageView.isHidden = true
        UIView.animate(withDuration: 1) {
            self.scrollView.layoutIfNeeded()
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        guard let location = locationManager.location else { return }
        weatherManager.updateWeatherInfo(latitude: location.coordinate.latitude, longtitude: location.coordinate.longitude) { [weak self] completionData in
            guard let self = self else { return }
            self.updateData(completionData)
        }
        refreshControl.endRefreshing()
    }
}
//MARK: Info view delegate
extension MainViewController: InfoViewDelegate {
    func hideInfo() {
        self.constraintTop?.update(priority: .high)
        self.constraintCenterX?.update(priority: .high)
        self.constraintCenter?.update(priority: .low)
        UIView.animate(withDuration: 1) {
            self.scrollView.layoutIfNeeded()
        } completion: { [weak self] done in
            if done {
                guard let self = self else { return }
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
        weatherManager.updateWeatherInfo(latitude: lastLocation.coordinate.latitude, longtitude: lastLocation.coordinate.longitude) { [weak self] completionData in
            guard let self = self else { return }
            self.updateData(completionData)
        }
    }
}
//MARK: Constants
extension MainViewController {
    enum Constants {
        static let topGradientColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 0.3).cgColor
        static let bottomGradientColor = UIColor(red: 0.353, green: 0.784, blue: 0.98, alpha: 0.3).cgColor
        static let gradientTransform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.92, b: 0, c: 13.08, d: 1.46, tx: -7.04, ty: -0.23))
        static let gradientStartPoint = CGPoint(x: 0.75, y: 0.5)
        static let gradientEndPoint = CGPoint(x: 0.25, y: 0.5)
        enum Offsets {
            static let leftSide: CGFloat = 16
            static let brickSide: CGFloat = 75
            enum InfoButton {
                static let height: CGFloat = 85
                static let width: CGFloat = 175
                static let top: CGFloat = 43
                static let bottom: CGFloat = 25
            }
            enum InfoView {
                static let width: CGFloat = 277
                static let heigth: CGFloat = 372
            }
        }
    }
}


