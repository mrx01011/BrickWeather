//
//  InfoButton.swift
//  WeatherForecastBrick
//
//  Created by Vladyslav Nhuien on 23.10.2022.
//

import UIKit

final class InfoButton: UIButton {
    private let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [Constants.InfoButton.topGradientColor,
                           Constants.InfoButton.bottomGradientColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = Constants.InfoButton.gradientStartPoint
        gradient.endPoint = Constants.InfoButton.gradientEndPoint
        gradient.cornerRadius = Constants.InfoButton.gradientCornerRadius
        return gradient
    }()
    
    //MARK: Initialization
    init() {
        super.init(frame: Constants.InfoButton.frame)
        defaultConfiguration()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    //MARK: Methods
    private func defaultConfiguration() {
        setTitle(Constants.InfoButton.buttonTitle, for: .normal)
        setTitleColor(Constants.InfoButton.titleColor, for: .normal)
        titleLabel?.font = Constants.InfoButton.titleFont
        titleEdgeInsets = Constants.InfoButton.titleEdgeInsets
        gradient.frame = self.frame
        layer.insertSublayer(gradient, at: 0)
    }
}

