//
//  CachedImageView.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 15.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import UIKit

final class CachedImageView: UIImageView {

    private static var cache = [URL: UIImage]()

    private var currentTask: URLSessionDataTask?

    // Реализация на коленке
    func setImage(url: URL?, placeholder: UIImage?) {
        cancelLoading()

        guard let url = url else {
            image = placeholder
            return
        }

        if let cachedImage = Self.cache[url] {
            image = cachedImage
            return
        }

        image = placeholder

        currentTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
            guard
                let data = data,
                self?.currentTask?.originalRequest?.url == url
            else {
                return
            }

            guard let image = UIImage(data: data) else {
                return
            }

            DispatchQueue.main.async {
                Self.cache[url] = image
                self?.image = image
            }
        }
        currentTask?.resume()
    }

    func cancelLoading() {
        currentTask?.cancel()
    }
}
