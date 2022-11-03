//
//  InfoView.swift
//  WeatherForecastBrick
//
//  Created by Vladyslav Nhuien on 23.10.2022.
//

import UIKit
import SnapKit

protocol InfoViewDelegate: AnyObject {
    func hideInfo()
}

final class InfoView: UIView {
    //MARK: Delegate
    weak var delegate: InfoViewDelegate?
    //MARK: UI Elements
    private let infoView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.backgroundColor
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Title.text
        label.textColor = Constants.labelColor
        label.font = Constants.Title.font
        return label
    }()
    private let infoLabel: UILabel = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.74
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = NSMutableAttributedString(
            string: Constants.InfoLabel.text,
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.textColor = Constants.labelColor
        label.font = Constants.InfoLabel.font
        return label
    }()
    private let hideButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.HideButton.titleText, for: .normal)
        button.layer.cornerRadius = Constants.HideButton.cornerRadius
        button.layer.borderColor = Constants.HideButton.borderColor
        button.layer.borderWidth = Constants.HideButton.borderWidth
        button.setTitleColor(Constants.HideButton.titleColor, for: .normal)
        button.titleLabel?.font = Constants.HideButton.titleFont
        return button
    }()
    //MARK: Initialization
    init() {
        super.init(frame: .zero)
        defaultConfiguration()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    //MARK: Methods
    private func setupUI() {
        //Info view
        addSubview(infoView)
        infoView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(Constants.Offsets.infoViewTrailing)
        }
        //Title label
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.Offsets.spacing)
            make.centerX.equalToSuperview()
        }
        //Info label
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Offsets.spacing)
            make.centerX.equalToSuperview()
        }
        //Hide button
        addSubview(hideButton)
        hideButton.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(Constants.Offsets.top)
            make.bottom.equalToSuperview().inset(Constants.Offsets.spacing)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.Offsets.hideButtonHeight)
            make.width.equalTo(Constants.Offsets.hideButtonWidth)
        }
    }
    
    private func defaultConfiguration() {
        backgroundColor = Constants.backgroundDark
        layer.cornerRadius = Constants.cornerRadius
        hideButton.addTarget(self, action: #selector(hideInfo), for: .touchUpInside)
    }
    
    @objc private func hideInfo() {
        self.delegate?.hideInfo()
    }
}
//MARK: Constants
extension InfoView {
    enum Constants {
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
        enum Offsets {
            static let spacing: CGFloat = 24
            static let top: CGFloat = 32
            static let hideButtonHeight: CGFloat = 31
            static let hideButtonWidth: CGFloat = 115
            static let infoViewTrailing: CGFloat =  8
        }
    }
}
