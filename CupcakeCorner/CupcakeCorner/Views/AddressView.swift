//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Pavel Bartashov on 2/10/2024.
//

import SwiftUI

struct AddressView: View {

    @Bindable var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }

            Section {
                NavigationLink("Checkout") {
                    CheckoutView(order: order)
                }
                .disabled(order.hasValidAddress == false)
            }
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AddressView(order: Order())
    }
}
