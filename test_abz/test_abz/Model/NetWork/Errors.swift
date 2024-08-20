//
//  Errors.swift
//  test_abz
//
//  Created by mac on 20.08.2024.
//

import Foundation

// MARK: - Error Handling
enum NWManagerError: Error {
    case networkError
    case invalidResponse
    case invalidData
    case decodingError
    case timeout
    case customError(String)
    case errorResponce(ErrorResponse)
}
