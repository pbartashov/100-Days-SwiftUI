//
//  DetailedUserView.swift
//  SwiftDataProject
//
//  Created by Pavel Bartashov on 7/10/2024.
//

import SwiftUI

struct DetailedUserView: View {

    let user: User

    var body: some View {
        HStack {
            StatusView(isActive: user.isActive)

            Text(user.isActive ? "Active" : "Inactive")
        }

        Form {
            Section("General") {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Age: \(user.age.formatted())")

                    Text("Company: \(user.company)")

                    Text("[\(user.email)](\(user.email))")

                    Text(user.address)

                    Text("Registered: \(user.registered.formatted(.dateTime))")
                }
            }

            Section("About") {
                Text(user.about)

            }

            Section("Friends") {
                ForEach(user.friends, id: \.self) {
                    Text($0.name)
                }
            }

            Section("Tags") {
                Text(
                    user.tags
                        .map {
                            "#\($0)"
                        }
                        .joined(separator: ", ")
                )
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DetailedUserView(user: User.demo)
    }
}

extension User {
    static var demo: User {
        User(
            id: "50a48fa3-2c0f-4397-ac50-64da464f9954",
            isActive: false,
            name: "Alford Rodriguez",
            age: 21,
            company: "Coca Cola",
            email: "1@1.com",
            address: "907 Nelson Street, Cotopaxi, South Dakota, 5913",
            about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.",
            registered: .now,
            tags: [
                "cillum",
                "consequat",
                "deserunt",
                "nostrud",
                "eiusmod",
                "minim",
                "tempor"
            ],
            friends: [
                Friend(id: "50a48fa3-2c0f-4397-ac50-64da464f9954", name: "Friend 1"),
                Friend(id: "50a48fa3-2c0f-4397-ac50-64da464f9954", name: "Friend 2"),
                Friend(id: "50a48fa3-2c0f-4397-ac50-64da464f9954", name: "Friend 3"),
                Friend(id: "50a48fa3-2c0f-4397-ac50-64da464f9954", name: "Friend 4")
            ])
    }
}
