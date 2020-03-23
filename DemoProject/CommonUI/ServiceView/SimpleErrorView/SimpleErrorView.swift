//
//  SimpleErrorView.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 20.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

final class SimpleErrorView: UIView, ServiceView {
    typealias Model = SimpleErrorViewModel

    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with model: Model) {
        label.text = model.description
    }

    private func setupViews() {
        backgroundColor = Color.background
        setupLabel()
    }

    private func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .body)
        label.tintColor = Color.tint
    }
}
