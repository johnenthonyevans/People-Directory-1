//
//  ContentView.swift
//  People Directory 1
//
//  Created by John Evans on 2/18/26.
//

import SwiftUI

struct ContentView: View {
    let people = PeopleData.load()
    @State private var searchText = ""

    var filteredPeople: [Person] {
        if searchText.isEmpty { return people }
        return people.filter {
            $0.fullName.localizedCaseInsensitiveContains(searchText) ||
            $0.role.localizedCaseInsensitiveContains(searchText) ||
            $0.audience.localizedCaseInsensitiveContains(searchText) ||
            $0.country.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredPeople) { person in
                NavigationLink(value: person) {
                    PersonRowView(person: person)
                }
            }
            .searchable(text: $searchText, prompt: "Search people")
            .navigationTitle("People")
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
                if !person.role.isEmpty {
                    Text("\(person.role) · \(person.audience)")
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
                .listRowInsets(EdgeInsets())
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
