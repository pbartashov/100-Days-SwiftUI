//
//  PathStore.swift
//  Navigation
//
//  Created by Pavel Bartashov on 30/9/2024.
//

import SwiftUI

@Observable
final class PathStore {
    var path: NavigationPath {
        didSet {
            save()
        }
    }

    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")

    init() {
        guard
            let data = try? Data(contentsOf: savePath),
            let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data)
        else {
            path = NavigationPath()
            return
        }


        path = NavigationPath(decoded)
    }

    private func save() {
        do {
            guard let representation = path.codable else {
                throw PathstoreError.codableError
            }

            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Fail to save navigation data")
        }
    }

    enum PathstoreError: Error {
        case codableError
    }
}
