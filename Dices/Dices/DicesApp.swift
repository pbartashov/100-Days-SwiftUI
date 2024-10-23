//
//  DicesApp.swift
//  Dices
//
//  Created by Pavel Bartashov on 23/10/2024.
//

import SwiftData
import SwiftUI

@main
struct DicesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: DiceResult.self)
        }
    }
}
