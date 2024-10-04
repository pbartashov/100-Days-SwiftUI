//
//  ContentView.swift
//  Bookworm
//
//  Created by Pavel Bartashov on 3/10/2024.
//


import SwiftData
import SwiftUI

struct ContentView: View {

    @Environment(\.modelContext) private var modelContext
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) private var books: [Book]

    @State private var showAddScreen = false

    let badRatingColor = Color.red

    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                    .foregroundStyle(book.rating < 2 ? badRatingColor : .primary)

                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationBarTitle("Bookworm")
            .navigationDestination(for: Book.self) { book in
                BookDetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add book", systemImage: "plus") {
                        showAddScreen.toggle()
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showAddScreen) {
                AddBookView()
            }
        }
    }

    private func deleteBooks(offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    let previewDataProvider = PreviewDataProvider()
    if let error = previewDataProvider.error {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }

    return ContentView()
        .modelContainer(previewDataProvider.container)
}
