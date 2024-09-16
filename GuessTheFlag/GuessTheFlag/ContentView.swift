//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Pavel Bartashov on 16/9/2024.
//

import SwiftUI

struct ContentView: View {

    @State private var a = 1

    @State var showingAlert = false
    @State var showingAlert2 = false
    var body: some View {
//        VStack {
//            ForEach(0..<3) { _ in
//                HStack {
//                    ForEach(0..<3) { _ in
//                        Text("Hello, world!")
//                    }
//                }
//            }
//        }
        ZStack {
            VStack {
                Button("Button 1") { }
                    .buttonStyle(.bordered)
                Button("Button 2", role: .destructive) { }
                    .buttonStyle(.bordered)
                Button("Button 3") { }
                    .tint(.mint)
                    .buttonStyle(.borderedProminent)
                Button("Button 4", role: .destructive) { }
                    .buttonStyle(.borderedProminent)
                Button {
                   a += 1
                } label: {
                    Text("Tap me!")
                        .padding()
                        .foregroundStyle(.white)
                        .background(.red)
                    Text("Now")
                }

                Button {
                    print("Edit button was tapped")
                } label: {
                    Image(systemName: "pencil")
                }

                Button("Edit", systemImage: "pencil") {
                    print("Edit button was tapped")
                }
                .padding()
                .foregroundStyle(.white)
                .background(.red)


                HStack {
                    Button {
                        showingAlert2 = true
                    } label: {
                        Label("Edit", systemImage: "pencil")
                            .padding()
                            .foregroundStyle(.white)
                            .background(.red)
                    }
                    Button("Show Alert") {
                        showingAlert = true
                    }
                    .alert("Important message1", isPresented: $showingAlert) {
                        Button("OK", role: .destructive) { }
                    } message: {
                        Text("Please read this.")
                    }
                    .alert("Important message2", isPresented: $showingAlert2) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text("Please read this.")
                    }
                }
            }
        }
        .ignoresSafeArea()

        Text(a.formatted())
    }
}

#Preview {
    ContentView()
}
