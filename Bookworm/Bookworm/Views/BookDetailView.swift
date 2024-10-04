//
//  BookDetailView.swift
//  Bookworm
//
//  Created by Pavel Bartashov on 3/10/2024.
//

import SwiftData
import SwiftUI

struct BookDetailView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var showingAlert = false

    let book: Book

    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre.rawValue)
                    .resizable()
                    .scaledToFit()

                Text(book.genre.rawValue.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }

            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)

            Text(book.date, style: .date)
                .foregroundStyle(.gray)

            Text(book.review)
                .padding()

            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingAlert = true
            }
        }
        .alert("Delete book", isPresented: $showingAlert) {
            Button("Delete", role: .destructive) {
                modelContext.delete(book)
                dismiss()
            }

            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
    }
}

#Preview {
    let previewDataProvider = PreviewDataProvider()
    if let error = previewDataProvider.error {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }

    return NavigationStack {
        BookDetailView(book: previewDataProvider.demoBook)
            .modelContainer(previewDataProvider.container)
    }
}
