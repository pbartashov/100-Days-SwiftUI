//
//  PreviewDataProvider.swift
//  Bookworm
//
//  Created by Pavel Bartashov on 3/10/2024.
//

import SwiftData

@MainActor
struct PreviewDataProvider {

    let container: ModelContainer!
    let demoBook: Book!
    let error: Error?

    init() {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            container = try ModelContainer(for: Book.self, configurations: config)
            demoBook = Book(title: "Test Book", author: "Test Author", genre: .fantasy, review: "This was a great book; I really enjoyed it.", rating: 4, date: .now)
            container.mainContext.insert(demoBook)

            error = nil
        } catch {
            container = nil
            demoBook = nil
            self.error = error
        }
    }
}
