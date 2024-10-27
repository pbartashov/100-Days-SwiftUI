//
//  Resort.swift
//  SnowSeeker
//
//  Created by Pavel Bartashov on 24/10/2024.
//

import Foundation

struct Resort {
    var id: String
    var name: String
    var country: String
    var description: String
    var imageCredit: String
    var price: Int
    var size: Int
    var snowDepth: Int
    var elevation: Int
    var runs: Int
    var facilities: [String]
}

extension Resort: Codable { }

extension Resort: Hashable { }

extension Resort: Identifiable { }

extension Resort {
    static let example = (Bundle.main.decode("resorts.json") as [Resort])[0]
}

extension Resort {
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
}
