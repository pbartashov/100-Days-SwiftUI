//
//  PreviewDataProvider.swift
//  NamedPhotos
//
//  Created by Pavel Bartashov on 15/10/2024.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
struct PreviewDataProvider {

    let container: ModelContainer!
    let demo: Item!
    let error: Error?

    init() {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Item.self, configurations: config)

            try container.mainContext.delete(model: Item.self)

            self.demo = Item.demo
            container.mainContext.insert(demo)

            self.container = container
            self.error = nil

            addMoreItems()
        } catch {
            self.container = nil
            self.demo = nil
            self.error = error
        }
    }

    private func addMoreItems() {
        let first = Item(name: "Test 1", imageSystemName: "arrow.left")

        container.mainContext.insert(first)

        let second = Item(name: "Test 2", imageSystemName: "circle")

        container.mainContext.insert(second)

        let third = Item(name: "Test 3", imageSystemName: "rectangle")

        container.mainContext.insert(third)

        let fourth = Item(name: "Test 4", imageSystemName: "arrow.right")

        container.mainContext.insert(fourth)

        let fifth = Item(name: "Test 5", imageSystemName: "arrow.up")

        container.mainContext.insert(fifth)

        let sixth = Item(name: "Test 6", imageSystemName: "arrow.down")

        container.mainContext.insert(sixth)
    }
}

extension Image {
    @MainActor
    var data: Data {
        let renderer = ImageRenderer(content: self)
        guard let image = renderer.uiImage else {
            fatalError("Error creating Renderer")
        }

        guard let data = image.pngData() else {
            fatalError("Error reading pngData")
        }

        return data
    }
}

@MainActor
extension Item {
    convenience init(name : String, imageSystemName: String) {
        self.init(name: name, image: Image(systemName: imageSystemName).data)
    }

    static let demo = Item(
        name: "Test",
        image: Image(systemName: "star").data,
        location: Location(latitude: 51.507222, longitude: -0.1275)
    )

    static let demoNoLocation = Item(name: "Test", imageSystemName: "star")
}
