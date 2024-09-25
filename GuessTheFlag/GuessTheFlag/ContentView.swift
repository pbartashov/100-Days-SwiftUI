//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Pavel Bartashov on 16/9/2024.
//

import SwiftUI

struct ContentView: View {

    private enum Constants {
        static let flagsToShowCount = 3
        static let rangeOfFlagNumbers = 0..<Constants.flagsToShowCount
    }

    private struct FlagAnimationData {
        static let defaultOpacity = 1.0
        static let defaultRotation = 0.0
        static let defaultScale = 1.0

        var rotation = defaultRotation
        var opacity = defaultOpacity
        var scale = defaultScale
    }

    private let flagsToShowCount = 3

    private let maxAttemptCount = 8
    @State private var attemptCount = 0

    @State private var showingCurrentScore = false
    @State private var showingFinalScore = false
    @State private var scoreTitle = ""
    @State private var score = 0

    @State private var flagsAnimationData = Array(
        repeating: FlagAnimationData(),
        count: Constants.flagsToShowCount
    )

    @State private var countries = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Nigeria",
        "Poland",
        "Spain",
        "UK",
        "Ukraine",
        "US"
    ].shuffled()

    @State private var correctAnswer = Int.random(in: Constants.rangeOfFlagNumbers)

    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    .init(
                        color: Color(
                            red: 0.1, green: 0.2, blue: 0.45
                        ),
                        location: 0.3
                    ),
                    .init(
                        color: Color(
                            red: 0.76, green: 0.15, blue: 0.26
                        ),
                        location: 0.3
                    ),
                ],
                center: .top,
                startRadius: 200,
                endRadius: 400
            ).ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(Constants.rangeOfFlagNumbers, id: \.self) { number in
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                setFlagsProperties(excludingNumber: number, opacity: 0.25, scale: 0.5)
                            }

                            withAnimation(.spring(duration: 1)) {
                                flagsAnimationData[number].rotation = 360
                            } completion: {
                                flagsAnimationData[number].rotation = FlagAnimationData.defaultRotation
                                setFlagsProperties(
                                    excludingNumber: number,
                                    opacity: FlagAnimationData.defaultOpacity,
                                    scale: FlagAnimationData.defaultScale
                                )

                                flagTapped(number)
                            }
                        } label: {
                            FlagImage(imageName: countries[number])
                                .rotation3DEffect(
                                    .degrees(flagsAnimationData[number].rotation),
                                    axis: (x: 0, y: 1, z: 0)
                                )
                                .scaleEffect(flagsAnimationData[number].scale)
                                .opacity(flagsAnimationData[number].opacity)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingCurrentScore) {
            Button("Continue", action: nextQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game over!", isPresented: $showingFinalScore) {
            Button("Continue", action: reset)
        } message: {
            Text("Your final score is \(score)")
        }
    }

    private func flagTapped(_ answer: Int) {
        if answer == correctAnswer {
            scoreTitle = "You are right!"
            score += 1
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[answer])"
        }

        showingCurrentScore = true
        attemptCount += 1
    }

    private func nextQuestion() {
        if attemptCount < maxAttemptCount {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        } else {
            showingFinalScore = true
        }
    }

    private func reset() {
        attemptCount = 0
        score = 0

        nextQuestion()
    }

    private func setFlagsProperties(
        excludingNumber number: Int,
        opacity: Double,
        scale: Double
    ) {
        for index in Constants.rangeOfFlagNumbers {
            if index == number {
                flagsAnimationData[index].opacity = FlagAnimationData.defaultOpacity
                flagsAnimationData[index].scale = FlagAnimationData.defaultScale
            } else {
                flagsAnimationData[index].opacity = opacity
                flagsAnimationData[index].scale = scale
            }
        }
    }
}

#Preview {
    ContentView()
}
