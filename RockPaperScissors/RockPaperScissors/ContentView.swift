//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Pavel Bartashov on 19/9/2024.
//

import SwiftUI

struct ContentView: View {

    private let maxTurns = 10
    @State  private var currentTurn = 0

    @State private var move = Move.random()
    @State private var userShouldWin = Bool.random()
    @State private var userScore = 0

    @State private var showingTie = false
    @State private var showingScore = false
    @State private var showingFinalScore = false

    @State private var scoreAlertTitle = ""

    var body: some View {
        VStack {
            Text("Score \(userScore)")
                .font(.largeTitle)

            Spacer()

            VStack(spacing: 10) {
                Text("I got")

                MoveView(move: move, size: 80)

                Text("You should")

                if userShouldWin {
                    LargeText(text: "win", color: .green)
                } else {
                    LargeText(text: "lose", color: .red)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 20))

            Spacer()

            VStack {
                Text("Your choice")
                ForEach(Move.availableMoves, id: \.self) { move in
                    Button {
                        moveTapped(userMove: move)
                    } label: {
                        MoveView(move: move, size: 100)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 20))
        }
        .padding()
        .alert("It's a tie! Choose a different move.", isPresented: $showingTie) {
            Button("Continue") { }
        }
        .alert(scoreAlertTitle, isPresented: $showingScore) {
            Button("Continue", action: nextTurn)
        } message: {
            Text("Your score is \(userScore)")
        }
        .alert("Game over!", isPresented: $showingFinalScore) {
            Button("Continue", action: reset)
        } message: {
            Text("Your final score is \(userScore)")
        }
    }

    private func nextTurn() {
        guard currentTurn < maxTurns else {
            showingFinalScore = true
            return
        }

        move = Move.random()
        userShouldWin = Bool.random()
    }

    private func moveTapped(userMove: Move) {
        guard move != userMove else {
            showingTie = true
            return
        }

        let userWins: Bool

        switch move {
            case .rock:
                userWins = (userMove == .paper)
            case .paper:
                userWins = (userMove == .scissors)
            case .scissors:
                userWins = (userMove == .rock)
        }

        if userShouldWin && userWins
            || !(userShouldWin || userWins) {

            userScore += 1
            scoreAlertTitle = "Lucky!"
        } else {
            userScore -= 1
            scoreAlertTitle = "Unlucky!"
        }

        showingScore = true
        currentTurn += 1
    }

    private func reset() {
        userScore = 0
        currentTurn = 0

        nextTurn()
    }
}

#Preview {
    ContentView()
}
