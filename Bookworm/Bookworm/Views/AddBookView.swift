//
//  AddBookView.swift
//  Bookworm
//
//  Created by Pavel Bartashov on 3/10/2024.
//

import SwiftData
import SwiftUI

struct AddBookView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = Genre.fantasy
    @State private var review = ""
    @State private var date = Date.now
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of a book", text: $title)
                    
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(Genre.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Section {
                    DatePicker("Date of publication", selection: $date, displayedComponents: .date)
                }
            }
            .navigationTitle("Add book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, date: date)
                        modelContext.insert(newBook)
                        
                        dismiss()
                    }
                    .disabled(title.hasNotContent || author.hasNotContent)
                }
            }
        }
    }
}

#Preview {
    AddBookView()
}
