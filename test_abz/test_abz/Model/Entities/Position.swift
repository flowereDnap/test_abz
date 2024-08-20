//
//  Position.swift
//  test_abz
//
//  Created by mac on 19.08.2024.
//

import Foundation

struct Position: Codable {
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
