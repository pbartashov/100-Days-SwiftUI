//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Pavel Bartashov on 3/10/2024.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
