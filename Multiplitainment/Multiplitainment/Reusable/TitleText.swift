//
//  TitleText.swift
//  Multiplitainment
//
//  Created by Pavel Bartashov on 25/9/2024.
//

import SwiftUI

struct TitleText: View {

    private var key: LocalizedStringKey
    private var tableName: String?
    private var bundle: Bundle?
    private var comment: StaticString?

    var body: some View {
        Text(key, tableName: tableName, bundle: bundle, comment: comment)
            .font(.title)
    }

    init(
        _ key: LocalizedStringKey,
        tableName: String? = nil,
        bundle: Bundle? = nil,
        comment: StaticString? = nil
    ) {
        self.key = key
        self.tableName = tableName
        self.bundle = bundle
        self.comment = comment
    }

    init(
        _ text: String,
        tableName: String? = nil,
        bundle: Bundle? = nil,
        comment: StaticString? = nil
    ) {
        self.key = LocalizedStringKey(text)
        self.tableName = tableName
        self.bundle = bundle
        self.comment = comment
    }
}

#Preview {
    TitleText("Hello world!")
}

