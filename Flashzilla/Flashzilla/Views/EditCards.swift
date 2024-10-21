//
//  EditCards.swift
//  Flashzilla
//
//  Created by Pavel Bartashov on 20/10/2024.
//

import SwiftUI

struct EditCards: View {

    let cardStore = CardStore()

    @Environment(\.dismiss) private var dismiss
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""

    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                    Button("Add sample data", action: addSampeData)
                }


                Section {
                    ForEach(0..<cards.count, id:\.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)

                            Text(cards[index].answer)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: deleteCard)
                }
            }
            .navigationTitle("Edit cards")
            .toolbar {
                Button("Done", action: done)
            }
            .onAppear(perform: loadData)
        }
    }

    private func deleteCard(at atOffsets: IndexSet) {
        cards.remove(atOffsets: atOffsets)
        saveData()
    }

    private func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }

        let newCard = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(newCard, at: 0)

        saveData()

        newPrompt = ""
        newAnswer = ""
    }

    private func done() {
        dismiss()
    }

    private func loadData() {
        cards = cardStore.loadCards()
    }

    private func saveData() {
        cardStore.saveCards(cards)
    }

    private func addSampeData() {
        cards += CardStore.sampleCards
        saveData()
    }
}

#Preview {
    NavigationStack {
        EditCards()
    }
}
