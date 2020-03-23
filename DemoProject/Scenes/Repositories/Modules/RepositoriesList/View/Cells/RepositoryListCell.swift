//
//  RepositoryListCell.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 05.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

final class RepositoryListCell: UICollectionViewCell {

    private enum Constants {
        enum Avatar {
            static let size = CGSize(width: 40, height: 40)
            static let rightMargin: CGFloat = 10
        }
        enum Title {
            static let bottomMargin: CGFloat = 5
            static let textStyle = UIFont.TextStyle.title3
            static let numberOfLines = 2
        }
        enum Description {
            static let bottomMargin: CGFloat = 8
            static let textStyle = UIFont.TextStyle.caption2
            static let numberOfLines = 2
        }
        enum Border {
            static let height: CGFloat = 0.5
            static let color = Color.tint.withAlphaComponent(0.25)
        }
        static let contentInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }

    private let avatarImageView = CachedImageView(image: Image.avatarPlaceholder)
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let infoView = RepositoryListCellInfoView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        frame.size.width = layoutAttributes.size.width
        return layoutAttributes
    }

    private func setupViews() {
        backgroundColor = Color.background
        setupSelectedBackgroundView()
        setupBorder()
        setupAvatarImageView()
        setupTitleLabel()
        setupDescriptionLabel()
        setupInfoView()
    }

    private func setupSelectedBackgroundView() {
        let view = UIView()
        view.backgroundColor = Color.tint.withAlphaComponent(0.1)
        selectedBackgroundView = view
    }

    private func setupBorder() {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = Constants.Border.color
        contentView.addSubview(border)
        border.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        border.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        border.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        border.heightAnchor.constraint(equalToConstant: Constants.Border.height).isActive = true
    }

    private func setupAvatarImageView() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(avatarImageView)
        avatarImageView.widthAnchor.constraint(equalToConstant: Constants.Avatar.size.width).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: Constants.Avatar.size.height).isActive = true
        avatarImageView.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: Constants.contentInsets.left
        ).isActive = true
        avatarImageView.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: Constants.contentInsets.top
        ).isActive = true

        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.backgroundColor = Color.background
        avatarImageView.tintColor = Color.tint
    }

    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(
            equalTo: avatarImageView.trailingAnchor,
            constant: Constants.Avatar.rightMargin
        ).isActive = true
        titleLabel.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: Constants.contentInsets.top
        ).isActive = true
        titleLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -Constants.contentInsets.right
        ).isActive = true

        titleLabel.font = .preferredFont(forTextStyle: Constants.Title.textStyle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = Constants.Title.numberOfLines
    }

    private func setupDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(
            equalTo: avatarImageView.trailingAnchor,
            constant: Constants.Avatar.rightMargin
        ).isActive = true
        descriptionLabel.topAnchor.constraint(
            equalTo: titleLabel.bottomAnchor,
            constant: Constants.Title.bottomMargin
        ).isActive = true
        descriptionLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -Constants.contentInsets.right
        ).isActive = true

        descriptionLabel.font = .preferredFont(forTextStyle: Constants.Description.textStyle)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.numberOfLines = Constants.Description.numberOfLines
    }

    private func setupInfoView() {
        infoView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(infoView)
        infoView.leadingAnchor.constraint(
            equalTo: avatarImageView.trailingAnchor,
            constant: Constants.Avatar.rightMargin
        ).isActive = true
        infoView.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -Constants.contentInsets.right
        ).isActive = true
        infoView.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -Constants.contentInsets.bottom
        ).isActive = true
    }
}

// MARK: - ConfigurableCell
extension RepositoryListCell: ConfigurableCell {
    // Расчет высоты и верстка упрощены для демо.
    // С другой стороны, если верстка позволяет, такое упрощение идет только на пользу.
    // В совсем простых ячейках можно использовать autosizing. (Но есть нюансы)
    // Но опять же зависит от минимальных требований по поддержке девайсов и ОС
    static func height(with model: CellModel, forWidth width: CGFloat) -> CGFloat {
        var height = Constants.contentInsets.top
        height += UIFont.preferredFont(forTextStyle: Constants.Title.textStyle).lineHeight
            * CGFloat(Constants.Title.numberOfLines)
        height += Constants.Title.bottomMargin
        height += UIFont.preferredFont(forTextStyle: Constants.Description.textStyle).lineHeight
            * CGFloat(Constants.Description.numberOfLines)
        height += Constants.Description.bottomMargin
        height += RepositoryListCellInfoView.height()
        height += Constants.contentInsets.bottom

        return height
    }

    func configure(with model: CellModel) {
        guard let model = model as? RepositoryListCellModel else {
            return
        }
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        avatarImageView.setImage(url: model.authorAvatar, placeholder: Image.avatarPlaceholder)
        infoView.set(
            language: model.language,
            languageColor: model.languageColor,
            starsCount: model.starsCount,
            forksCount: model.forksCount
        )
    }
}
