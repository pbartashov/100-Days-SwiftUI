//
//  PathStore.swift
//  Habits
//
//  Created by Pavel Bartashov on 2/10/2024.
//

import SwiftUI

@Observable
final class PathStore {
    var path: NavigationPath {
        didSet {
            save()
        }
    }

    init() {
        guard
            let data = UserDefaults.standard.data(forKey: Constants.pathUserDefaultKey),
            let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data)
        else {
            path = NavigationPath()
            return
        }

        path = NavigationPath(decoded)
    }

    private func save() {
        if let representation = path.codable,
           let data = try? JSONEncoder().encode(representation) {
            UserDefaults.standard.setValue(data, forKey: Constants.pathUserDefaultKey)
        }
    }
}
