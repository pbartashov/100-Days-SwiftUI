//
//  Questions.swift
//  Multiplitainment
//
//  Created by Pavel Bartashov on 25/9/2024.
//

import SwiftUI

struct Questions: View {

    let questions: [Question]
    let onFinish: (Int) -> Void

    @State private var currentQuestion = 0
    @State private var answer: Int? = nil
    @State private var userScore = 0

    @FocusState private var fieldFocused

    var body: some View {
        VStack(spacing: 50) {
            UltraThinCard {
                TitleText(questions[currentQuestion].question)
                    .foregroundStyle(.white)

                TextField("Your answer", value: $answer, format: .number)
                    .focused($fieldFocused)
                    .onSubmit(nextQuestion)
                    .font(.largeTitle)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.mint, lineWidth: 4)
                    }
                    .onAppear {
                        fieldFocused = true
                    }
            }

            BrandedButton {
                nextQuestion()
            } label: {
                Label("Next", systemImage: "arrowshape.forward")
            }
            .foregroundStyle(.white)
        }
    }

    private func nextQuestion() {
        if answer == questions[currentQuestion].answer {
            userScore += 1
        }

        answer = nil

        if currentQuestion < questions.count - 1 {
            currentQuestion += 1
        } else {
            onFinish(userScore)
        }
    }
}

#Preview {
    ZStack {
        Color.teal
            .ignoresSafeArea()

        Questions(
            questions: [(5, 6), (8, 6), (8, 9), (12, 10), (11, 5)]
                .map { (currentMultiplier0, currentMultiplier1) in
                    Question(
                        question: "What is \(currentMultiplier0) x \(currentMultiplier1)?",
                        answer: (currentMultiplier0 * currentMultiplier1)
                    )
                }
        ) { _ in }
    }
}
