//
//  DetailedView.swift
//  NamedPhotos
//
//  Created by Pavel Bartashov on 15/10/2024.
//

import SwiftUI

struct DetailedView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var item: Item
    
    var onSave: ((Item) -> Void)
    
    var body: some View {
        VStack {
            Image(data: item.imageData)?
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            TextField("Name", text: $item.name)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
            
            Spacer()
            
            MapView(item: $item)
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Save") {
                    onSave(item)
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    init(item: Item, onSave: @escaping (Item) -> Void) {
        self._item = State(initialValue: item)
        self.onSave = onSave
    }
}

#Preview {
    NavigationStack {
        DetailedView(item: Item.demo, onSave: { _ in })
    }
}
