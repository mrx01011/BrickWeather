//
//  BrickImageView.swift
//  WeatherForecastBrick
//
//  Created by Vladyslav Nhuien on 23.10.2022.
//

import UIKit

final class BrickImageView: UIImageView {
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
        image = UIImage(named: "image_stone_normal.png")
    }
}
