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
        defaultConfiguration()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    //MARK: Methods
    private func defaultConfiguration() {
        image = UIImage(named: Constants.ImageView.ImageNames.normal)
    }
    
    private func applyState(state: BrickState) {
        var image: UIImage
        var alpha: CGFloat
        
        self.layer.removeAllAnimations()
        
        switch state {
        case .rain(let windy):
            image = UIImage(named: Constants.ImageView.ImageNames.wet) ?? UIImage()
            alpha = 1
            if windy {
                layer.add(pendulumAnimation, forKey: Constants.ImageView.animationKey)
            }
        case .sunny(let windy):
            image = UIImage(named: Constants.ImageView.ImageNames.normal) ?? UIImage()
            alpha = 1
            if windy {
                layer.add(pendulumAnimation, forKey: Constants.ImageView.animationKey)
            }
        case .fog(let windy):
            image = UIImage(named: Constants.ImageView.ImageNames.normal) ?? UIImage()
            alpha = 0.2
            if windy {
                layer.add(pendulumAnimation, forKey: Constants.ImageView.animationKey)
            }
        case .hot(let windy):
            image = UIImage(named: Constants.ImageView.ImageNames.cracks) ?? UIImage()
            alpha = 1
            if windy {
                layer.add(pendulumAnimation, forKey: Constants.ImageView.animationKey)
            }
        case .snow(let windy):
            image = UIImage(named: Constants.ImageView.ImageNames.snow) ?? UIImage()
            alpha = 1
            if windy {
                layer.add(pendulumAnimation, forKey: Constants.ImageView.animationKey)
            }
        }
        self.image = image
        self.alpha = alpha
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
