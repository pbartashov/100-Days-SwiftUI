//
//  TrailingIconLabelStyle.swift
//  Multiplitainment
//
//  Created by Pavel Bartashov on 25/9/2024.
//

import SwiftUI

//https://spencerwalden.com.au/swiftui-label-with-icon-trailing/
struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}
