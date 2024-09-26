//
//  Question.swift
//  Multiplitainment
//
//  Created by Pavel Bartashov on 25/9/2024.
//

import Foundation

struct Question {
    let question: String
    let answer: Int
}

extension Question: Equatable { }

extension Question {
    init() {
        self.question = "What is 2 x 2?"
        self.answer = 4
    }
}
