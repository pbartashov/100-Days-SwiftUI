//
//  Item.swift
//  NamedPhotos
//
//  Created by Pavel Bartashov on 15/10/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var name: String
    var location: Location?
    @Attribute(.externalStorage) var imageData: Data
    @Transient var isNew = false
    
    init(name: String, image: Data, location: Location? = nil, isNew: Bool = false) {
        self.name = name
        self.imageData = image
        self.isNew = isNew
        self.location = location
    }
}
