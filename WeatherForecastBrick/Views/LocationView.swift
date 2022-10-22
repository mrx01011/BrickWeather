//
//  LocationView.swift
//  WeatherForecastBrick
//
//  Created by Vladyslav Nhuien on 23.10.2022.
//

import UIKit
import SnapKit

final class LocationView: UIView {
    //MARK: UI Elements
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Krakow, Poland"
        label.textColor = Constants.LocationLabel.textColor
        label.font = Constants.LocationLabel.font
        return label
    }()
    private let vectorIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_location.pdf"))
        return imageView
    }()
    private let searchIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_search.pdf"))
        return imageView
    }()
    //MARK: Initialization
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    //MARK: Methods
    private func setupUI() {
        addSubview(vectorIcon)
        vectorIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.leading.equalTo(vectorIcon.snp.trailing).offset(Constants.OffSets.LocationView.horizontalSpacing)
            make.verticalEdges.equalToSuperview()
        }
        addSubview(searchIcon)
        searchIcon.snp.makeConstraints { make in
            make.leading.equalTo(locationLabel.snp.trailing).offset(Constants.OffSets.LocationView.horizontalSpacing)
            make.trailing.equalToSuperview()
        }
    }
}
