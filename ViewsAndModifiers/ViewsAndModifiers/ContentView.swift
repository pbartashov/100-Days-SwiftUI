//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Pavel Bartashov on 17/9/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Hello, world!") {
                print(type(of: self.body))
            }
            .background(.red)
            .frame(width: 200, height: 200)

            Button("Hello, world!") {
                print(type(of: self.body))
            }
            .frame(width: 200, height: 200)
            .background(.red)

            Text("Hello, world!")
                .padding()
                .background(.red)

                .padding()
                .background(.blue)
                .padding()
                .background(.green)
                .padding()
                .background(.yellow)
            VStack {
                Text("Gryffindor")
                    .blur(radius: 2)
                Text("Hufflepuff")
                Text("Ravenclaw")
                Text("Slytherin")
            }
            .blur(radius: 2)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
