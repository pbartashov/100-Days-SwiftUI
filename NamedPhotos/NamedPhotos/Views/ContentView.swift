//
//  ContentView.swift
//  NamedPhotos
//
//  Created by Pavel Bartashov on 15/10/2024.
//

import PhotosUI
import SwiftUI
import SwiftData

struct ContentView: View {

    @State private var path = NavigationPath()

    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\Item.name)]) private var items: [Item]
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var showingPhotoPicker = false

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(items) { item in
                    NavigationLink(value: item) {
                        HStack {
                            Text(item.name)
                                .frame(maxWidth: 100)

                            Spacer()

                            Image(data: item.imageData)?
                                .resizable()
                                .scaledToFit()
                                .containerRelativeFrame(.horizontal, { length, axis in
                                    axis == .horizontal ? length * 0.6 : length
                                })
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationDestination(for: Item.self, destination: { item in
                DetailedView(item: item) { newItem in
                    modelContext.insert(newItem)
                    newItem.isNew = false
                }
            })
            .navigationTitle("Names")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }

                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .photosPicker(isPresented: $showingPhotoPicker, selection: $photosPickerItem)
            .onChange(of: photosPickerItem) {
                Task {
                    if let image = try await photosPickerItem?.loadTransferable(type: Image.self) {
                        let newItem = Item(name: "", image: image.data, isNew: true)
                        path.append(newItem)
                    }
                }
            }
        }
    }

    private func addItem() {
        showingPhotoPicker = true
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(PreviewDataProvider().container)
}

extension Image {
    init?(data: Data) {
        guard let uiImage = UIImage(data: data) else {
            return nil
        }

        self.init(uiImage: uiImage)
    }
}
