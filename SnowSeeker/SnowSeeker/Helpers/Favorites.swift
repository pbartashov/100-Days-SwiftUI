//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Pavel Bartashov on 24/10/2024.
//

import SwiftUI

@Observable
final class Favorites {
    private var resorts: Set<String> = []
    private let key = "Favorites"

    init () {
        load()
    }

    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }

    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }

    func save() {
        UserDefaults.standard.set(Array(resorts), forKey: key)
    }

    func load() {
        let array = UserDefaults.standard.array(forKey: key) as? [String]
        resorts = Set(array ?? [])
    }
}
