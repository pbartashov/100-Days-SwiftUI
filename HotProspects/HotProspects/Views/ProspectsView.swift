//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Pavel Bartashov on 16/10/2024.
//

import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

struct ProspectsView: View {

    @Environment(\.modelContext) var modelContext

    @State private var isShowingScanner = false

    @State private var isShowingMessage = false
    @State private var message = ""

    @State private var sorting = SortType.name
    let filter: FilerType

    var body: some View {
        NavigationStack {
            ProspectsListView(filter: filter, sorting: sorting) { error in
                show(error: error)
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    EditButton()

                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sorting) {
                            Text("Sort by name").tag(SortType.name)
                            Text("Sort by date").tag(SortType.date)
                        }
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        isShowingScanner = true
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
            }
            .alert(message, isPresented: $isShowingMessage) {
                Button("Ok", action: { })
            }
        }
    }

    var title: String {
        switch filter {
            case .none:
                "Everyone"
            case .contacted:
                "Contacted people"
            case .uncontacted:
                "Uncontacted people"
        }
    }

    private func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false

        switch result {
            case .success(let success):
                let details = success.string.components(separatedBy: "\n")

                guard details.count == 2 else {
                    show(message: "Unaible to decode QR code")
                    return
                }

                let prospect = Prospect(name: details[0], emailAddress: details[1], isContacted: false)
                modelContext.insert(prospect)
            case .failure(let error):
                show(error: error)
        }
    }

    private func show(error: Error) {
        show(message: error.localizedDescription)
    }

    private func show(message text: String) {
        message = text
        isShowingMessage = true
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
