//
//  CustomFlowLayout.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 19.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

final class CustomFlowLayout: UICollectionViewFlowLayout {

    private enum Constants {
        static let minCellWidth: CGFloat = 300
        static let estimatedCellHeight: CGFloat = 100
        static let maxColumns: CGFloat = 3
    }

    var cellWidth: CGFloat = 0

    override init() {
        super.init()

        minimumLineSpacing = 0
        sectionInsetReference = .fromSafeArea
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func invalidateLayout() {
        updateCellWidth()

        estimatedItemSize = .init(width: cellWidth, height: Constants.estimatedCellHeight)

        super.invalidateLayout()
    }

    private func updateCellWidth() {
        guard let collectionView = collectionView else {
            self.cellWidth = .leastNonzeroMagnitude
            return
        }

        let layoutFrame = collectionView.safeAreaLayoutGuide.layoutFrame
        let safeAreaInsets = collectionView.safeAreaInsets
        var availableWidth = layoutFrame.width - sectionInset.left - sectionInset.right
        if layoutFrame.width > layoutFrame.height && safeAreaInsets.left > safeAreaInsets.right {
            // Обработка бага iOS. При повороте экрана в landscape на iPhone с челкой, safeAreaInsets.right бывает == 0
            availableWidth -= safeAreaInsets.left
        }

        var columnNumber = Constants.maxColumns
        var cellWidth: CGFloat = 0
        while cellWidth < Constants.minCellWidth {
            let interitemSpacingSum = minimumInteritemSpacing * (columnNumber - 1)
            cellWidth = (availableWidth - interitemSpacingSum) / columnNumber
            columnNumber -= 1
        }

        self.cellWidth = cellWidth.rounded(.down)
    }
}
