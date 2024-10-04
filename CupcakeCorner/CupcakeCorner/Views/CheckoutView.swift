//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Pavel Bartashov on 2/10/2024.
//

import SwiftUI

struct CheckoutView: View {

    var order: Order

    @State private var alertTitle = ""
    @State private var alertMessge = ""
    @State var showingAlert = false

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place order"){
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
            .navigationTitle("Check out")
            .navigationBarTitleDisplayMode(.inline)
            .scrollBounceBehavior(.basedOnSize)
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessge)
            }
        }
    }

    private func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decoded = try JSONDecoder().decode(Order.self, from: data)

            alertTitle = "Thank you!"
            alertMessge = "Your order for \(decoded.quantity)x \(Order.types[decoded.type].lowercased()) cupcakes is on its way!"
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
            alertTitle = "Checkout failed"
            alertMessge = "\(error.localizedDescription)\nPlease try again later."
        }

        showingAlert = true
    }
}

#Preview {
    NavigationStack {
        CheckoutView(order: Order())
    }
}
