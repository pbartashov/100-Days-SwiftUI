//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Pavel Bartashov on 5/10/2024.
//

import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
