//
//  NetworkError.swift
//  Movies
//
//  Created by msc on 20.09.2021.
//

import Foundation

enum NetworkError: Error {

    case failedToCreateUrl
    case networkingError(Error)
    case noResponseOrData
    case deserializationError(Error)
    case serializationError(Error)
    case invalidStatusCode(Int)
    case forcedFailure
}
