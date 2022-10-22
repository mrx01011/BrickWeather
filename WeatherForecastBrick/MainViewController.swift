//
//  ViewController.swift
//  WeatherForecastBrick
//
//  Created by Vladyslav Nhuien on 23.10.2022.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    //MARK: InfoView Constraints
    private var constraintTop: ConstraintMakerFinalizable? = nil
    private var constraintWidth: ConstraintMakerFinalizable? = nil
    private var constraintHeight: ConstraintMakerFinalizable? = nil
    private var constraintCenterX: ConstraintMakerFinalizable? = nil
    private var constraintCenter: ConstraintMakerFinalizable? = nil
    //MARK: UIElements
    private let temperatureLabel = TemperatureLabel()
    private let weatherLabel = WeatherLabel()
    private let infoButton = InfoButton()
    private let infoView = InfoView()
    private let brickImageView = BrickImageView()
    private let contentView = UIView()
    private let scrollView = UIScrollView()
    private let refreshControl = UIRefreshControl()
    private let locationView = LocationView()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        defaultConfiguration()
        addTargets()
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
        //Temperature label
        view.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.OffSets.MainViewController.leftSide)
            make.trailing.equalToSuperview().offset(Constants.OffSets.MainViewController.tempLabelTrailing)
        }
        //Weather label
        view.addSubview(weatherLabel)
        weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom)
            make.leading.equalToSuperview().offset(Constants.OffSets.MainViewController.leftSide)
            make.trailing.equalToSuperview().offset(Constants.OffSets.MainViewController.weatherLabelTrailing)
        }
        //Location label
        view.addSubview(locationView)
        locationView.snp.makeConstraints { make in
            make.top.equalTo(weatherLabel.snp.bottom).offset(Constants.OffSets.MainViewController.locationViewTop)
            make.centerX.equalToSuperview()
        }
        //Info button
        view.addSubview(infoButton)
        infoButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.OffSets.MainViewController.InfoButton.height)
            make.width.equalTo(Constants.OffSets.MainViewController.InfoButton.width)
            make.centerX.equalToSuperview()
            make.top.equalTo(locationView.snp.bottom).offset(Constants.OffSets.MainViewController.InfoButton.top)
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
    
    @objc private func showInfo() {
        UIView.animate(withDuration: 1) {
            self.constraintTop?.constraint.update(priority: .low)
            self.constraintCenterX?.constraint.update(priority: .low)
            self.constraintCenter?.constraint.update(priority: .high)
            self.scrollView.layoutIfNeeded()
            self.infoButton.isHidden = true
            self.weatherLabel.isHidden = true
            self.temperatureLabel.isHidden = true
            self.brickImageView.isHidden = true
            self.locationView.isHidden = true
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        refreshControl.endRefreshing()
    }
}

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
                self.weatherLabel.isHidden = false
                self.temperatureLabel.isHidden = false
                self.brickImageView.isHidden = false
                self.locationView.isHidden = false
            }
        }
    }
}

