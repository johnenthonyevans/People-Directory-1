//
//  ContentView.swift
//  People Directory 1
//
//  Created by John Evans on 2/18/26.
//

import SwiftUI

enum GroupBy: String, CaseIterable {
    case name = "Name"
    case level = "Level"
    case location = "Location"
}

struct ContentView: View {
    let people = PeopleData.load()
    @State private var searchText = ""
    @State private var groupBy: GroupBy = .name

    var filteredPeople: [Person] {
        if searchText.isEmpty { return people }
        return people.filter {
            $0.fullName.localizedCaseInsensitiveContains(searchText) ||
            $0.role.localizedCaseInsensitiveContains(searchText) ||
            $0.audience.localizedCaseInsensitiveContains(searchText) ||
            $0.country.localizedCaseInsensitiveContains(searchText)
        }
    }

    var groupedPeople: [(key: String, people: [Person])] {
        let grouped: [String: [Person]]
        switch groupBy {
        case .name:
            grouped = Dictionary(grouping: filteredPeople) { person in
                String(person.fullName.prefix(1)).uppercased()
            }
        case .level:
            grouped = Dictionary(grouping: filteredPeople) { $0.level.isEmpty ? "Unknown" : $0.level }
        case .location:
            grouped = Dictionary(grouping: filteredPeople) { $0.country.isEmpty ? "Unknown" : $0.country }
        }
        return grouped
            .map { (key: $0.key, people: $0.value.sorted { $0.fullName < $1.fullName }) }
            .sorted {
                if groupBy == .level {
                    let num0 = Int($0.key.dropFirst()) ?? Int.max
                    let num1 = Int($1.key.dropFirst()) ?? Int.max
                    return num0 < num1
                }
                return $0.key < $1.key
            }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(groupedPeople, id: \.key) { section in
                    Section(section.key) {
                        ForEach(section.people) { person in
                            NavigationLink(value: person) {
                                PersonRowView(person: person)
                            }
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search people")
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("Group by", selection: $groupBy) {
                        ForEach(GroupBy.allCases, id: \.self) { group in
                            Text(group.rawValue).tag(group)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 220)
                }
            }
            .navigationDestination(for: Person.self) { person in
                PersonDetailView(person: person)
            }
        }
    }
}

struct PersonRowView: View {
    let person: Person

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(.gray.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay {
                    Text(person.initials)
                        .font(.subheadline.weight(.medium))
                }
            VStack(alignment: .leading, spacing: 2) {
                Text(person.fullName)
                    .font(.body.weight(.medium))
                if !person.role.isEmpty || !person.audience.isEmpty {
                    Text([person.role, person.audience].filter { !$0.isEmpty }.joined(separator: " · "))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

struct PersonDetailView: View {
    let person: Person

    var body: some View {
        List {
            Section {
                HStack(spacing: 16) {
                    Circle()
                        .fill(.gray.opacity(0.3))
                        .frame(width: 64, height: 64)
                        .overlay {
                            Text(person.initials)
                                .font(.title2.weight(.semibold))
                        }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(person.fullName)
                            .font(.title2.weight(.semibold))
                        if !person.track.isEmpty {
                            Text(person.track)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    Spacer()
                }
                .padding(.vertical, 12)
            }
            Section("Details") {
                if !person.level.isEmpty {
                    LabeledContent("Level", value: person.level)
                }
                if !person.role.isEmpty {
                    LabeledContent("Role", value: person.role)
                }
                if !person.country.isEmpty {
                    LabeledContent("Country", value: person.country)
                }
                if !person.audience.isEmpty {
                    LabeledContent("Audience", value: person.audience)
                }
            }
        }
        .navigationTitle(person.fullName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
}
