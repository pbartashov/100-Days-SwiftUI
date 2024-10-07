//
//  ContentView.swift
//  iExpense
//
//  Created by Pavel Bartashov on 26/9/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State private var showingAddExpense = false
    @State private var lastModified = Date.now
    
    @State private var filter = ExpenseType.all
    
    @State private var sortDescriptors = [
        SortDescriptor<ExpenseItem>(\.name),
        SortDescriptor<ExpenseItem>(\.amount)
    ]
    
    private var didSavePublisher: NotificationCenter.Publisher {
        NotificationCenter.default
            .publisher(for: ModelContext.didSave, object: modelContext)
    }
    
    var body: some View {
        NavigationStack {
            List {
                if filter == .all {
                    ItemsSectionView(
                        title: ExpenseType.personal.rawValue,
                        filterBy: .personal,
                        sort: sortDescriptors,
                        deletion: removeItems
                    )
                    
                    ItemsSectionView(
                        title: ExpenseType.business.rawValue,
                        filterBy: .business,
                        sort: sortDescriptors,
                        deletion: removeItems
                    )
                } else {
                    ItemsSectionView(
                        title: filter.rawValue,
                        filterBy: filter,
                        sort: sortDescriptors,
                        deletion: removeItems
                    )
                }
            }
            
            Text("Last modified: \(lastModified, format: .dateTime)")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .onReceive(didSavePublisher) { _ in
                    lastModified = Date.now
                }
            
                .navigationTitle("iExpenses")
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Picker("Filter", selection: $filter) {
                            ForEach(ExpenseType.allCases, id: \.self) {
                                Text($0.rawValue).tag($0)
                            }
                        }
                        .pickerStyle(.segmented)
                        .fixedSize()
                    }
                    
                    ToolbarItemGroup(placement: .primaryAction) {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort by", selection: $sortDescriptors) {
                                Text("Sort by name")
                                    .tag([
                                        SortDescriptor<ExpenseItem>(\.name),
                                        SortDescriptor<ExpenseItem>(\.amount)
                                    ])
                                
                                Text("Sort by amount")
                                    .tag([
                                        SortDescriptor<ExpenseItem>(\.amount),
                                        SortDescriptor<ExpenseItem>(\.name)
                                    ])
                            }
                        }
                        
                        Button("Add Expense", systemImage: "plus") {
                            showingAddExpense = true
                        }
                    }
                }
                .navigationDestination(isPresented: $showingAddExpense) {
                    AddView()
                        .navigationBarBackButtonHidden()
                }
        }
    }
    
    private func removeItems(withIds uuids: [UUID]) {
        do {
            try modelContext.delete(
                model: ExpenseItem.self,
                where: #Predicate<ExpenseItem> { expense in
                    uuids.contains(expense.id)
                }
            )
        } catch {
            print(error.localizedDescription)
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
