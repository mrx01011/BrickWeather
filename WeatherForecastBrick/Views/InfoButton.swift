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
        gradient.colors = [Constants.topGradientColor,
                           Constants.bottomGradientColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = Constants.gradientStartPoint
        gradient.endPoint = Constants.gradientEndPoint
        gradient.cornerRadius = Constants.gradientCornerRadius
        return gradient
    }()
    
    //MARK: Initialization
    init() {
        super.init(frame: Constants.frame)
        defaultConfiguration()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    //MARK: Methods
    private func defaultConfiguration() {
        setTitle(Constants.buttonTitle, for: .normal)
        setTitleColor(Constants.titleColor, for: .normal)
        titleLabel?.font = Constants.titleFont
        titleEdgeInsets = Constants.titleEdgeInsets
        gradient.frame = self.frame
        layer.insertSublayer(gradient, at: 0)
    }
}
//MARK: Constants
extension InfoButton {
    enum Constants {
        static let frame = CGRect(x: 0, y: 0, width: 175, height: 85)
        static let buttonTitle = "INFO"
        static let titleColor = UIColor(red: 0.175, green: 0.175, blue: 0.175, alpha: 1)
        static let titleFont = UIFont(name: "SFProDisplay-Semibold", size: 18) ?? UIFont.systemFont(ofSize: 18)
        static let titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 47, right: 0)
        static let topGradientColor = UIColor(red: 1, green: 0.6, blue: 0.375, alpha: 1).cgColor
        static let bottomGradientColor = UIColor(red: 0.977, green: 0.315, blue: 0.106, alpha: 1).cgColor
        static let gradientStartPoint = CGPoint(x: 0.5, y: 0.25)
        static let gradientEndPoint = CGPoint(x: 0.5, y: 0.75)
        static let gradientCornerRadius: CGFloat = 16
    }
}
