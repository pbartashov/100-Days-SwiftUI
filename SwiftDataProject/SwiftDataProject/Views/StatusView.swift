//
//  StatusView.swift
//  SwiftDataProject
//
//  Created by Pavel Bartashov on 7/10/2024.
//

import SwiftUI

struct StatusView: View {

    let isActive: Bool

    var body: some View {
        Image(systemName: "circle.fill")
            .foregroundStyle(isActive ? .green : .gray)
    }
}
