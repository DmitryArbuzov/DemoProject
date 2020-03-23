//
//  RepositoryListCellInfoView.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 09.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

final class RepositoryListCellInfoView: UIView {

    private enum Constants {
        enum Icon {
            static let size = CGSize(width: 16, height: 16)
        }
        enum LanguageIcon {
            static let size = CGSize(width: 13, height: 13)
            static let defaulColor = UIColor.lightGray
        }
        enum Label {
            static let margins = UIEdgeInsets(top: 1, left: 3, bottom: 0, right: 1)
            static let textStyle = UIFont.TextStyle.footnote
            static let minWidth: CGFloat = 25
        }
    }

    static func height() -> CGFloat {
        Constants.Label.margins.top
            + UIFont.preferredFont(forTextStyle: Constants.Label.textStyle).lineHeight
            + Constants.Label.margins.bottom
    }

    private let languageIconView = UIView()
    private let languageNameLabel = UILabel()
    private let starsIconView = UIImageView(image: Image.star)
    private let starsCountLabel = UILabel()
    private let forksIconView = UIImageView(image: Image.fork)
    private let forksCountLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(language: String, languageColor: UIColor?, starsCount: UInt, forksCount: UInt) {
        languageIconView.backgroundColor = languageColor ?? Constants.LanguageIcon.defaulColor
        languageNameLabel.text = language
        starsCountLabel.text = String(starsCount)
        forksCountLabel.text = String(forksCount)
    }

    private func setupViews() {
        setupLanguageIconView()
        setupLanguageLabel()
        setupStartCountLabel()
        setupStarsIconView()
        setupForksCountLabel()
        setupForksIconView()
    }

    private func setupLanguageIconView() {
        languageIconView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(languageIconView)
        languageIconView.widthAnchor.constraint(equalToConstant: Constants.LanguageIcon.size.width).isActive = true
        languageIconView.heightAnchor.constraint(equalToConstant: Constants.LanguageIcon.size.height).isActive = true
        languageIconView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        languageIconView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        languageIconView.layer.masksToBounds = true
        languageIconView.layer.cornerRadius = Constants.LanguageIcon.size.width / 2.0
    }

    private func setupLanguageLabel() {
        languageNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(languageNameLabel)
        languageNameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.Label.minWidth).isActive = true
        languageNameLabel.leadingAnchor.constraint(
            equalTo: languageIconView.trailingAnchor,
            constant: Constants.Label.margins.left
        ).isActive = true
        languageNameLabel.topAnchor.constraint(
            equalTo: topAnchor,
            constant: Constants.Label.margins.top
        ).isActive = true
        languageNameLabel.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: Constants.Label.margins.bottom
        ).isActive = true

        languageNameLabel.font = .preferredFont(forTextStyle: Constants.Label.textStyle)
        languageNameLabel.adjustsFontForContentSizeCategory = true
    }

    private func setupStartCountLabel() {
        starsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(starsCountLabel)
        starsCountLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.Label.minWidth).isActive = true
        starsCountLabel.centerXAnchor.constraint(
            equalTo: centerXAnchor,
            constant: (Constants.Icon.size.width + Constants.Label.margins.left) / 2.0
        ).isActive = true
        starsCountLabel.topAnchor.constraint(
            equalTo: topAnchor,
            constant: Constants.Label.margins.top
        ).isActive = true
        starsCountLabel.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: Constants.Label.margins.bottom
        ).isActive = true
        starsCountLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)

        starsCountLabel.font = .preferredFont(forTextStyle: Constants.Label.textStyle)
        starsCountLabel.adjustsFontForContentSizeCategory = true
    }

    private func setupStarsIconView() {
        starsIconView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(starsIconView)
        starsIconView.widthAnchor.constraint(equalToConstant: Constants.Icon.size.width).isActive = true
        starsIconView.heightAnchor.constraint(equalToConstant: Constants.Icon.size.height).isActive = true
        starsIconView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        starsIconView.trailingAnchor.constraint(
            equalTo: starsCountLabel.leadingAnchor,
            constant: -Constants.Label.margins.left
        ).isActive = true
        languageNameLabel.trailingAnchor.constraint(
            lessThanOrEqualTo: starsIconView.leadingAnchor,
            constant: Constants.Label.margins.right
        ).isActive = true

        starsIconView.tintColor = Color.tint
    }

    private func setupForksCountLabel() {
        forksCountLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(forksCountLabel)
        forksCountLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.Label.minWidth).isActive = true
        forksCountLabel.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -Constants.Label.margins.right
        ).isActive = true
        forksCountLabel.topAnchor.constraint(
            equalTo: topAnchor,
            constant: Constants.Label.margins.top
        ).isActive = true

        forksCountLabel.font = .preferredFont(forTextStyle: Constants.Label.textStyle)
        forksCountLabel.adjustsFontForContentSizeCategory = true
    }

    private func setupForksIconView() {
        forksIconView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(forksIconView)
        forksIconView.heightAnchor.constraint(equalToConstant: Constants.Icon.size.height).isActive = true
        forksIconView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        forksIconView.trailingAnchor.constraint(
            equalTo: forksCountLabel.leadingAnchor,
            constant: -Constants.Label.margins.left
        ).isActive = true

        forksIconView.tintColor = Color.tint
    }
}
