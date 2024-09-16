//
//  UnitDuration.swift
//  EasyConverter
//
//  Created by Pavel Bartashov on 13/9/2024.
//

import Foundation

extension UnitDuration {
    static let days = UnitDuration(symbol: "days", converter: UnitConverterLinear(coefficient: 60 * 60 * 24))
}
