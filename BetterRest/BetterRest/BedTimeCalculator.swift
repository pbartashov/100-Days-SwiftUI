//
//  BedTimeCalculator.swift
//  BetterRest
//
//  Created by Pavel Bartashov on 20/9/2024.
//

import CoreML

struct BedTimeCalculator {

    static func calculate(
        wakeUp: Date,
        estimatedSleep: Double,
        coffee: Double
    ) throws -> Date {

        let config = MLModelConfiguration()
        let model = try SleepCalculator(configuration: config)

        let hours = Calendar.current.component(.hour, from: wakeUp)
        let minutes = Calendar.current.component(.minute, from: wakeUp)

        let wake = hours * 60 * 60 + minutes * 60

        let prediction = try model.prediction(
            wake: Double(wake),
            estimatedSleep: estimatedSleep,
            coffee: coffee
        )

        return wakeUp - prediction.actualSleep
    }
}
