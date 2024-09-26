//
//  ContentView.swift
//  Multiplitainment
//
//  Created by Pavel Bartashov on 25/9/2024.
//

import SwiftUI

struct ContentView: View {

    @State private var showingSettings = true

    @State private var questions: [Question] = []

    @State private var userScore = 0
    @State private var showingUserScore = false
    @State private var scoreTitle = ""

    var body: some View {
        ZStack {
            Color.teal
                .ignoresSafeArea()

            if showingSettings {
                SettingsView { multiplier, numberOfAnswers in
                    makeQuestions(for: multiplier, numberOfAnswers: numberOfAnswers)

                    withAnimation {
                        showingSettings = false
                    }
                }
                .transition(.move(edge: .trailing))
                .padding()
            } else {
                Questions(questions: questions) { score in
                    self.userScore = score
                    scoreTitle = score > 0 ? "Well done!" : "Well..."

                    showingUserScore = true
                }
                .transition(.move(edge: .trailing))
                .padding()
            }
        }
        .alert(scoreTitle, isPresented: $showingUserScore) {
            Button("New game") {
                withAnimation {
                    showingSettings = true
                }
            }
        } message: {
            Text("Your score is \(userScore)")
        }
    }

    private func makeQuestions(for multiplier: Int, numberOfAnswers: Int) {
        questions = []

        let maxNumberOfAttempts = 100
        var numberOfAttempts = 0

        while questions.count < numberOfAnswers {
            let currentMultiplier0 = Int.random(in: 2...multiplier)
            let currentMultiplier1 = Int.random(in: 2...multiplier)

            let question = Question(
                question: "What is \(currentMultiplier0) x \(currentMultiplier1)?",
                answer: (currentMultiplier0 * currentMultiplier1)
            )

            numberOfAttempts += 1

            if !questions.contains(question)
                || maxNumberOfAttempts < numberOfAttempts {
                questions.append(question)
                numberOfAttempts = 0
            }
        }
    }
}

#Preview {
    ContentView()
}
