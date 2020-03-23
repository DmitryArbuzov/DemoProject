//
//  APIError.swift
//  DemoProject
//
//  Created by Dmitry Arbuzov on 14.03.2020.
//  Copyright © 2020 dm. All rights reserved.
//

import Foundation

enum APIError: Error {
    // Тут другие кейсы, которые может прислать API
    case network(NetworkError)
    case decoding(DecodingError)
    // Этот кейс тоже в проде должен быть превращен в несколько более конкретных в т.ч. с парсингом данных
    // в тех сервисах, где может придти в ответ тело ошибки
    case unacceptableStatusCode(code: Int, reason: String?)
    case noData
    case unknown(Error)
}
