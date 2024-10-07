//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Pavel Bartashov on 5/10/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {

    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]

    @State private var showingError = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            List(users) { user in
                NavigationLink(value: user) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(user.name)

                            Text(user.email)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        StatusView(isActive: user.isActive)
                    }
                }
            }
            .navigationTitle("User&Friends")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await fetchUsersIfNeeded()
            }
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK") { }
            } message: {
                Text(errorMessage)
            }
            .navigationDestination(for: User.self) { user in
                DetailedUserView(user: user)
            }
        }
    }

    private func fetchUsersIfNeeded() async {
        guard users.isEmpty else { return }
        
        do {
            let userProvider = UserProvider(context: modelContext)
            try await userProvider.fetchUsers()
        } catch {
            handle(error: error)
        }
    }

    private func handle(error: Error) {
        errorTitle = "Error"
        errorMessage = error.localizedDescription
        showingError = true
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self)
}
