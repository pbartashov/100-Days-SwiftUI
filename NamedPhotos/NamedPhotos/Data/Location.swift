//
//  Location.swift
//  NamedPhotos
//
//  Created by Pavel Bartashov on 15/10/2024.
//

import SwiftData

@Model
final class Location {
    var latitude: Double
    var longitude: Double

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension Location {
    static let `default` = Location(latitude: 51.507222, longitude: -0.1275)
}
