//
//  Constants.swift
//  WeatherForecastBrick
//
//  Created by Vladyslav Nhuien on 23.10.2022.
//

import Foundation
import UIKit

enum Constants {
    enum MainViewController {
        static let topGradientColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 0.3).cgColor
        static let bottomGradientColor = UIColor(red: 0.353, green: 0.784, blue: 0.98, alpha: 0.3).cgColor
        static let gradientTransform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.92, b: 0, c: 13.08, d: 1.46, tx: -7.04, ty: -0.23))
        static let gradientStartPoint = CGPoint(x: 0.75, y: 0.5)
        static let gradientEndPoint = CGPoint(x: 0.25, y: 0.5)
        enum TemperatureLabel {
            static let font = UIFont(name: "SFProDisplay-Semibold", size: 83) ?? UIFont.systemFont(ofSize: 83)
            static let textColor = UIColor(red: 0.175, green: 0.175, blue: 0.175, alpha: 1)
        }
        enum WeatherLabel {
            static let font = UIFont(name: "SFProDisplay-Light", size: 36) ?? UIFont.systemFont(ofSize: 36)
            static let textColor = UIColor(red: 0.175, green: 0.175, blue: 0.175, alpha: 1)
        }
    }
    enum InfoButton {
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
    enum InfoView {
        static let backgroundDark = UIColor(red: 0.984, green: 0.373, blue: 0.161, alpha: 1)
        static let backgroundColor = UIColor(red: 1, green: 0.6, blue: 0.375, alpha: 1)
        static let cornerRadius: CGFloat = 15
        static let labelColor = UIColor(red: 0.175, green: 0.175, blue: 0.175, alpha: 1)
        enum Title {
            static let text = "INFO"
            static let font = UIFont(name: "SFProDisplay-SemiBold", size: 18) ?? UIFont.systemFont(ofSize: 18)
        }
        enum InfoLabel {
            static let text = "Brick is wet - raining\nBrick is dry - sunny \nBrick is hard to see - fog\nBrick with cracks - very hot \nBrick with snow - snow\nBrick is swinging- windy\nBrick is gone - No Internet "
            static let font = UIFont(name: "SFProDisplay-Light", size: 15) ?? UIFont.systemFont(ofSize: 15)
        }
        enum HideButton {
            static let titleText = "Hide"
            static let cornerRadius: CGFloat = 15
            static let borderColor = UIColor(red: 0.342, green: 0.342, blue: 0.342, alpha: 1).cgColor
            static let borderWidth: CGFloat = 1
            static let titleColor = UIColor(red: 0.342, green: 0.342, blue: 0.342, alpha: 1)
            static let titleFont = UIFont(name: "SFProDisplay-Semibold", size: 15) ?? UIFont.systemFont(ofSize: 15)
        }
    }
    enum LocationLabel {
        static let textColor = UIColor(red: 0.175, green: 0.175, blue: 0.175, alpha: 1)
        static let font = UIFont(name: "SFProDisplay-Light", size: 17) ?? UIFont.systemFont(ofSize: 17)
    }
    enum OffSets {
        enum MainViewController {
            static let leftSide: CGFloat = 16
            static let tempLabelTrailing: CGFloat = 235
            static let weatherLabelTrailing: CGFloat = 266
            static let locationViewTop: CGFloat = 83
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
        enum InfoView {
            static let spacing: CGFloat = 24
            static let hideButtonHeight: CGFloat = 31
            static let hideButtonWidth: CGFloat = 115
            static let infoViewTrailing: CGFloat =  8
        }
        enum LocationView {
            static let horizontalSpacing: CGFloat = 5
        }
    }
}

