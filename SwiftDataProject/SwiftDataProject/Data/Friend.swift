//
//  Friend.swift
//  SwiftDataProject
//
//  Created by Pavel Bartashov on 7/10/2024.
//

import SwiftData

@Model
final class Friend: Codable  {
    var id: String
    var name: String

    init (id: String, name: String) {
        self.id = id
        self.name = name
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: ._id)
        name = try container.decode(String.self, forKey: ._name)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: ._id)
        try container.encode(name, forKey: ._name)
    }

    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case _name = "name"
    }
}

extension Friend: Hashable { }
