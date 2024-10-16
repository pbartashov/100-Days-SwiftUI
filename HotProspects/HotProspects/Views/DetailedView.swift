//
//  DetailedView.swift
//  HotProspects
//
//  Created by Pavel Bartashov on 16/10/2024.
//

import SwiftUI

struct DetailedView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let prospect: Prospect
    
    @State private var name = ""
    @State private var emailAddress = ""
    @State private var isContacted = false
    
    let onSave: (Prospect) -> Void
    
    var body: some View {
        Form {
            Section("Name") {
                TextField("Name", text: $name)
            }
            
            Section("Email address") {
                TextField("Email address", text: $emailAddress)
            }
            
            Section("Date") {
                Text(prospect.date, format: .dateTime)
                    .foregroundStyle(.secondary)
            }
            
            Toggle("Contacted", isOn: $isContacted)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    prospect.name = name
                    prospect.emailAddress = emailAddress
                    prospect.isContacted = isContacted
                    
                    onSave(prospect)
                    
                    dismiss()
                }
            }
        }
    }
    
    init(prospect: Prospect, onSave: @escaping (Prospect) -> Void) {
        self.prospect = prospect
        self.onSave = onSave
        
        self._name = State(initialValue: prospect.name)
        self._emailAddress = State(initialValue: prospect.emailAddress)
        self._isContacted = State(initialValue: prospect.isContacted)
    }
}

#Preview {
    NavigationStack {
        DetailedView(prospect: Prospect.default, onSave: { _ in })
    }
}
