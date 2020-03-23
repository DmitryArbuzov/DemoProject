//
//  SimpleLoadingView.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 20.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

final class SimpleLoadingView: UIView, LoadingView {

    private enum Constants {
        enum Title {
            static let topMargin: CGFloat = 10
        }
    }

    private let activityIndicator = UIActivityIndicatorView(style: .white)
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if !activityIndicator.isAnimating {
            activityIndicator.startAnimating()
        }
    }

    func update(with model: SimpleLoadingViewModel) {
        titleLabel.text = model.title
    }

    private func setupViews() {
        backgroundColor = Color.background
        setupActivityIndicator()
        setupTitleLabel()
    }

    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        activityIndicator.color = Color.tint
    }

    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(
            equalTo: activityIndicator.bottomAnchor,
            constant: Constants.Title.topMargin
        ).isActive = true

        titleLabel.textAlignment = .center
        titleLabel.font = .preferredFont(forTextStyle: .caption1)
        titleLabel.tintColor = Color.tint
    }
}
