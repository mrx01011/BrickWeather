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
        view.backgroundColor = Constants.InfoView.backgroundColor
        view.layer.cornerRadius = Constants.InfoView.cornerRadius
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.InfoView.Title.text
        label.textColor = Constants.InfoView.labelColor
        label.font = Constants.InfoView.Title.font
        return label
    }()
    private let infoLabel: UILabel = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.74
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = NSMutableAttributedString(
            string: Constants.InfoView.InfoLabel.text,
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.textColor = Constants.InfoView.labelColor
        label.font = Constants.InfoView.InfoLabel.font
        return label
    }()
    private let hideButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.InfoView.HideButton.titleText, for: .normal)
        button.layer.cornerRadius = Constants.InfoView.HideButton.cornerRadius
        button.layer.borderColor = Constants.InfoView.HideButton.borderColor
        button.layer.borderWidth = Constants.InfoView.HideButton.borderWidth
        button.setTitleColor(Constants.InfoView.HideButton.titleColor, for: .normal)
        button.titleLabel?.font = Constants.InfoView.HideButton.titleFont
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
            make.trailing.equalToSuperview().inset(Constants.OffSets.InfoView.infoViewTrailing)
        }
        //Title label
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.OffSets.InfoView.spacing)
            make.centerX.equalToSuperview()
        }
        //Info label
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.OffSets.InfoView.spacing)
            make.centerX.equalToSuperview()
        }
        //Hide button
        addSubview(hideButton)
        hideButton.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(32)
            make.bottom.equalToSuperview().inset(Constants.OffSets.InfoView.spacing)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.OffSets.InfoView.hideButtonHeight)
            make.width.equalTo(Constants.OffSets.InfoView.hideButtonWidth)
        }
    }
    
    private func defaultConfiguration() {
        backgroundColor = Constants.InfoView.backgroundDark
        layer.cornerRadius = Constants.InfoView.cornerRadius
        hideButton.addTarget(self, action: #selector(hideInfo), for: .touchUpInside)
    }
    
    @objc private func hideInfo() {
        self.delegate?.hideInfo()
    }
}


