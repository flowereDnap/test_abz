//
//  User.swift
//  test_abz
//
//  Created by mac on 19.08.2024.
//

import Foundation

//stores basic entity operated in the project
struct User: Decodable {
    let id: Int
    let registrationTimestamp: Int
    
    var name: String
    var email: String
    var phone: String
    var positionId: Int
    var position: String
    var photo: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case registrationTimestamp = "registration_timestamp"
        case name
        case email
        case phone
        case positionId = "position_id"
        case position
        case photo
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.registrationTimestamp = try container.decode(Int.self, forKey: .registrationTimestamp)
        self.name = try container.decode(String.self, forKey: .name)
        self.email = try container.decode(String.self, forKey: .email)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.positionId = try container.decode(Int.self, forKey: .positionId)
        self.position = try container.decode(String.self, forKey: .position)
        self.photo = try container.decode(String.self, forKey: .photo)
    }
}
