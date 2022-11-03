//
//  BrickImageView.swift
//  WeatherForecastBrick
//
//  Created by Vladyslav Nhuien on 23.10.2022.
//

import UIKit

final class BrickImageView: UIImageView {
    var brickState: BrickState = .hot(windy: false) {
        didSet {
            applyState(state: brickState)
        }
    }
    //MARK: Animation
    private let pendulumAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = Double.pi / 10
        animation.duration = 2
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        return animation
    }()
    //MARK: Initialization
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    //MARK: Methods
    private func applyState(state: BrickState) {
        let image: UIImage?
        let alpha: CGFloat
        self.layer.removeAllAnimations()
        
        switch state {
        case .rain:
            image = UIImage(named: Constants.ImageNames.wet)
            alpha = 1
        case .sunny:
            image = UIImage(named: Constants.ImageNames.normal)
            alpha = 1
        case .fog:
            image = UIImage(named: Constants.ImageNames.normal)
            alpha = 0.2
        case .hot:
            image = UIImage(named: Constants.ImageNames.cracks)
            alpha = 1
        case .snow:
            image = UIImage(named: Constants.ImageNames.snow)
            alpha = 1
        }
        self.image = image
        self.alpha = alpha
        if state.isWindy {
            layer.add(pendulumAnimation, forKey: Constants.animationKey)
        }
    }
}
//MARK: Brick state model
extension BrickImageView {
    enum BrickState {
        case rain(windy: Bool)
        case sunny(windy: Bool)
        case fog(windy: Bool)
        case hot(windy: Bool)
        case snow(windy: Bool)
        var isWindy: Bool {
            switch self {
            case .snow(let windy):
                return windy
            case .hot(let windy):
                return windy
            case .rain(let windy):
                return windy
            case .sunny(let windy):
                return windy
            case .fog(let windy):
                return windy
            }
        }
        init(temperature: Int, id: Int, windSpeed: Double) {
            if temperature > 30 {
                self = .hot(windy: windSpeed > 5)
            } else if id >= 200 && id <= 531 {
                self = .rain(windy: windSpeed > 5)
            } else if id >= 600 && id <= 622 {
                self = .snow(windy: windSpeed > 5)
            } else if id >= 700 && id < 800 {
                self = .fog(windy: windSpeed > 5)
            } else if id > 800 {
                self = .sunny(windy: windSpeed > 5)
            } else {
                self = .sunny(windy: false)
            }
        }
    }
}
//MARK: Constants
extension BrickImageView {
    enum Constants {
        static let animationKey = "rotateAnimation"
        enum ImageNames {
            static let normal = "image_stone_normal.png"
            static let wet = "image_stone_wet.png"
            static let cracks = "image_stone_cracks"
            static let snow = "image_stone_snow"
        }
    }
}
