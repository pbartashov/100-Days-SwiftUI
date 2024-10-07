//
//  User.swift
//  SwiftDataProject
//
//  Created by Pavel Bartashov on 7/10/2024.
//

import Foundation
import SwiftData

@Model
final class User: Codable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]

    init(
        id: String,
        isActive: Bool,
        name: String,
        age: Int,
        company: String,
        email: String,
        address: String,
        about: String,
        registered: Date,
        tags: [String],
        friends: [Friend]
    ) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tags = tags
        self.friends = friends
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: ._id)
        isActive = try container.decode(Bool.self, forKey: ._isActive)
        name = try container.decode(String.self, forKey: ._name)
        age = try container.decode(Int.self, forKey: ._age)
        company = try container.decode(String.self, forKey: ._company)
        email = try container.decode(String.self, forKey: ._email)
        address = try container.decode(String.self, forKey: ._address)
        about = try container.decode(String.self, forKey: ._about)
        registered = try container.decode(Date.self, forKey: ._registered)
        tags = try container.decode([String].self, forKey: ._tags)
        friends = try container.decode([Friend].self, forKey: ._friends)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: ._id)
        try container.encode(isActive, forKey: ._isActive)
        try container.encode(name, forKey: ._name)
        try container.encode(age, forKey: ._age)
        try container.encode(company, forKey: ._company)
        try container.encode(email, forKey: ._email)
        try container.encode(address, forKey: ._address)
        try container.encode(about, forKey: ._about)
        try container.encode(registered, forKey: ._registered)
        try container.encode(tags, forKey: ._tags)
        try container.encode(friends, forKey: ._friends)
    }

    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case _isActive = "isActive"
        case _name = "name"
        case _age = "age"
        case _company = "company"
        case _email = "email"
        case _address = "address"
        case _about = "about"
        case _registered = "registered"
        case _tags = "tags"
        case _friends = "friends"
    }
}

extension User: Identifiable { }

extension User: Hashable { }
