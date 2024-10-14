//
//  ContentView.swift
//  WordScramble
//
//  Created by Pavel Bartashov on 23/9/2024.
//

import SwiftUI

struct ContentView: View {

    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    @State private var score = 0

    var body: some View {
        NavigationStack {
            Text("Score \(score)")

            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }

                ForEach(usedWords, id: \.self) { word in
                    HStack {
                        Image(systemName: "\(word.count).circle")
                        Text(word)
                    }
                    .accessibilityElement()
                    .accessibilityLabel(word)
                    .accessibilityHint("\(word.count) letters")
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                Button("New game", action: startGame)
            }
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
            } message: {
                Text(errorMessage)
            }
        }
    }

    private func addNewWord() {
        let answer = newWord
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard isLongEnough(word: answer) else { return }

        guard isNotStartWord(word: answer) else {
            wordError(title: "Word is the start word", message: "You can't use the start word!")
            return
        }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used alredy", message: "Be more original!")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from \(rootWord)!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognised", message: "You can't just make them up, you know!")
            return
        }

        withAnimation {
            usedWords.insert(answer, at: 0)
        }

        newWord = ""

        score = score + answer.count + 1
    }

    private func startGame() {
        guard
            let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
            let startWords = try? String(contentsOf: startWordsURL)
        else {
            fatalError("Could not load start.txt from bundle")
        }

        let allWords = startWords.components(separatedBy: "\n")
        rootWord = allWords.randomElement() ?? "silkworm"

        score = 0

        usedWords = []
    }

    private func isLongEnough(word: String) -> Bool {
        word.count > 2
    }

    private func isNotStartWord(word: String) -> Bool {
        word != rootWord
    }

    private func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    private func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }

    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )

        return misspelledRange.location == NSNotFound
    }

    private func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    ContentView()
}
