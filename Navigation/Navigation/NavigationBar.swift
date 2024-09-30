//
//  NavigationBar.swift
//  Navigation
//
//  Created by Pavel Bartashov on 30/9/2024.
//

import SwiftUI

struct NavigationBar: View {
    @State private var title = "SwiftUI"

    var body: some View {
        NavigationStack {
            List(0..<100) { i in
                NavigationLink("Row \(i)") {
                    Text("Row \(i)")
                        .navigationBarBackButtonHidden()

                }
            }
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)

            .toolbarBackground(.blue)
            .toolbarColorScheme(.dark)
//            .toolbar(.hidden, for: .navigationBar)

            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Tap Me") {
                        // button action here
                    }

                    Button("Or Tap Me") {
                        // button action here
                    }
                }
            }

        }
    }
}


#Preview {
    NavigationBar()
}

