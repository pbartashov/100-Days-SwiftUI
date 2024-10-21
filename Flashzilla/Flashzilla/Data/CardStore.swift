//
//  CardStore.swift
//  Flashzilla
//
//  Created by Pavel Bartashov on 21/10/2024.
//

import Foundation

struct CardStore {
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")

    static var sampleCards: [Card] {
        (0...3)
            .map { _ in
                Card(prompt: example.prompt, answer: example.answer)
            }
    }

    let strogeURL = URL.documentsDirectory.appendingPathComponent("cards.json")

    func loadCards() -> [Card] {
        if let data = try? Data(contentsOf: strogeURL),
           let decoded = try? JSONDecoder().decode([Card].self, from: data) {
            return decoded
        }

        return []
    }

    func saveCards(_ cards: [Card]) {
        if let encoded = try? JSONEncoder().encode(cards) {
            try? encoded.write(to: strogeURL)
        }
    }
}
