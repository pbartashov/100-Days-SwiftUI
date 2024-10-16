//
//  ProspectsListView.swift
//  HotProspects
//
//  Created by Pavel Bartashov on 16/10/2024.
//

import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

struct ProspectsListView: View {

    @Query(sort: \Prospect.name) var prospects: [Prospect]
    @Environment(\.modelContext) var modelContext
    @State private var selectedProspects = Set<Prospect>()

    let filter: FilerType
    let onError: (Error) -> Void

    var body: some View {
        List(prospects, selection: $selectedProspects) { prospect in
            NavigationLink {
                DetailedView(prospect: prospect) { _ in
                    try? modelContext.save()
                }
            } label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)

                        Text(prospect.emailAddress)
                            .foregroundStyle(.secondary)
                    }

                    if prospect.isContacted && filter == .none {
                        Spacer()

                        Image(systemName: "person.crop.circle.badge.checkmark")
                            .foregroundStyle(.green)
                    }
                }
            }
            .tag(prospect)
            .swipeActions {
                Button("Delete", systemImage: "trash", role: .destructive) {
                    modelContext.delete(prospect)
                }

                if prospect.isContacted {
                    Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                        prospect.isContacted.toggle()
                    }
                    .tint(.blue)
                } else {
                    Button("Mark Contacted", systemImage: "person.crop.circle.badge.checkmark") {
                        prospect.isContacted.toggle()
                    }
                    .tint(.green)

                    Button("Remind Me", systemImage: "bell") {
                        addNotification(for: prospect)
                    }
                    .tint(.orange)
                }
            }
        }
        .toolbar {
            if selectedProspects.isEmpty == false {
                ToolbarItem(placement: .bottomBar) {
                    Button("Delete Selected", action: delete)
                }
            }
        }
        .onDisappear {
            selectedProspects.removeAll()
        }
    }

    init(
        filter: FilerType,
        sorting: SortType,
        onError: @escaping (Error) -> Void
    ) {
        self.filter = filter
        self.onError = onError

        let sortDescriptor: SortDescriptor<Prospect>

        switch sorting {
            case .name:
                sortDescriptor = SortDescriptor(\Prospect.name)
            case .date:
                sortDescriptor = SortDescriptor(\Prospect.date)
        }

        if filter == .none {
            self._prospects = Query(sort: [sortDescriptor])
        } else {
            let showContactedOnly = filter == .contacted
            self._prospects = Query(
                filter: #Predicate {
                    $0.isContacted == showContactedOnly
                },
                sort: [sortDescriptor]
            )
        }
    }

    private func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }

        selectedProspects.removeAll()
    }

    private func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        onError(error)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProspectsListView(filter: .none, sorting: SortType.name, onError: { _ in })
            .modelContainer(for: Prospect.self)
    }
}
