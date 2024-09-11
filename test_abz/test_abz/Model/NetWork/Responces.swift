//
//  Responces.swift
//  test_abz
//
//  Created by mac on 20.08.2024.
//

import Foundation



// MARK: - Response Structures

struct TokenResponse: Decodable {
    let success: Bool
    let token: String
}

struct PositionsResponse: Codable {
    let success: Bool
    let positions: [Position]
}


struct UsersResponse: Decodable {
    let success: Bool
    let totalPages: Int
    let totalUsers: Int
    let count: Int
    let page: Int
    let links: Links
    let users: [User]
    
    private enum CodingKeys: String, CodingKey {
        case success
        case totalPages = "total_pages"
        case totalUsers = "total_users"
        case count
        case page
        case links
        case users
    }
}

struct UserResponse: Decodable {
    let success: Bool
    let user_id: Int
    let message: String
}

struct ErrorResponse: Decodable, Error {
    let success: Bool
    let message: String
    let fails: [String:[String]]?
}


struct Links: Decodable {
    let nextURL: String?
    let prevURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case nextURL = "next_url"
        case prevURL = "prev_url"
    }
}
