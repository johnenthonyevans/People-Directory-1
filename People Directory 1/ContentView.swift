//
//  ContentView.swift
//  People Directory 1
//
//  Created by John Evans on 2/18/26.
//

import SwiftUI

// MARK: - Enums

enum GroupBy: String, CaseIterable {
    case name = "Name"
    case level = "Level"
    case location = "Location"
}

// MARK: - Level Badge Colors

extension Person {
    var levelColor: Color {
        switch levelNumber {
        case .some(3...5): return .green
        case .some(6...7): return .blue
        case .some(8...9): return .purple
        case .some(10...): return .orange
        default: return .gray
        }
    }
}

// MARK: - Content View

struct ContentView: View {
    let people = PeopleData.load()
    @State private var searchText = ""
    @State private var groupBy: GroupBy = .name
    @State private var selectedPerson: Person?
    @State private var filterLevel: String?
    @State private var filterLocation: String?
    @Namespace private var animation

    var availableLevels: [String] {
        Array(Set(people.compactMap { $0.level.isEmpty ? nil : $0.level }))
            .sorted {
                let n0 = Int($0.dropFirst()) ?? Int.max
                let n1 = Int($1.dropFirst()) ?? Int.max
                return n0 < n1
            }
    }

    var availableLocations: [String] {
        Array(Set(people.compactMap { $0.country.isEmpty ? nil : $0.country })).sorted()
    }

    var filteredPeople: [Person] {
        people.filter { person in
            if let level = filterLevel, person.level != level { return false }
            if let location = filterLocation, person.country != location { return false }
            if !searchText.isEmpty {
                return person.fullName.localizedCaseInsensitiveContains(searchText) ||
                    person.role.localizedCaseInsensitiveContains(searchText) ||
                    person.audience.localizedCaseInsensitiveContains(searchText) ||
                    person.country.localizedCaseInsensitiveContains(searchText)
            }
            return true
        }
    }

    var groupedPeople: [(key: String, people: [Person])] {
        let grouped: [String: [Person]]
        switch groupBy {
        case .name:
            grouped = Dictionary(grouping: filteredPeople) { String($0.fullName.prefix(1)).uppercased() }
        case .level:
            grouped = Dictionary(grouping: filteredPeople) { $0.level.isEmpty ? "Unknown" : $0.level }
        case .location:
            grouped = Dictionary(grouping: filteredPeople) { $0.country.isEmpty ? "Unknown" : $0.country }
        }
        return grouped
            .map { (key: $0.key, people: $0.value.sorted { $0.fullName.localizedCaseInsensitiveCompare($1.fullName) == .orderedAscending }) }
            .sorted {
                if groupBy == .level {
                    let n0 = Int($0.key.dropFirst()) ?? Int.max
                    let n1 = Int($1.key.dropFirst()) ?? Int.max
                    return n0 < n1
                }
                return $0.key < $1.key
            }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                // Filter chips
                filterBar

                LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                    ForEach(groupedPeople, id: \.key) { section in
                        Section {
                            ForEach(section.people) { person in
                                PersonCardView(person: person, namespace: animation)
                                    .onTapGesture { withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) { selectedPerson = person } }
                                    .contextMenu { PersonContextMenu(person: person) }
                                    .accessibilityLabel(person.accessibilityLabel)
                            }
                        } header: {
                            sectionHeader(section.key)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .background(Color(.systemGroupedBackground))
            .searchable(text: $searchText, prompt: "Search people")
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("Group by", selection: $groupBy) {
                        ForEach(GroupBy.allCases, id: \.self) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 220)
                }
            }
            .overlay {
                if let person = selectedPerson {
                    PersonDetailSheet(person: person, namespace: animation) {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) { selectedPerson = nil }
                    }
                }
            }
        }
    }

    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                Menu {
                    Button("All Levels") { filterLevel = nil }
                    ForEach(availableLevels, id: \.self) { level in
                        Button(level) { filterLevel = level }
                    }
                } label: {
                    FilterChip(title: filterLevel ?? "Level", isActive: filterLevel != nil)
                }

                Menu {
                    Button("All Locations") { filterLocation = nil }
                    ForEach(availableLocations, id: \.self) { loc in
                        Button(loc) { filterLocation = loc }
                    }
                } label: {
                    FilterChip(title: filterLocation ?? "Location", isActive: filterLocation != nil)
                }

                if filterLevel != nil || filterLocation != nil {
                    Button("Clear") {
                        filterLevel = nil
                        filterLocation = nil
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }

    private func sectionHeader(_ title: String) -> some View {
        HStack {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)
            Spacer()
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 4)
        .background(Color(.systemGroupedBackground))
    }
}

// MARK: - Filter Chip

struct FilterChip: View {
    let title: String
    let isActive: Bool

    var body: some View {
        HStack(spacing: 4) {
            Text(title)
                .font(.caption.weight(.medium))
            Image(systemName: "chevron.down")
                .font(.caption2)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(isActive ? Color.accentColor.opacity(0.15) : Color(.tertiarySystemFill))
        .foregroundStyle(isActive ? Color.accentColor : .primary)
        .clipShape(Capsule())
    }
}

// MARK: - Person Card

struct PersonCardView: View {
    let person: Person
    var namespace: Namespace.ID

    var body: some View {
        HStack(spacing: 14) {
            AvatarView(person: person)
                .matchedGeometryEffect(id: "avatar-\(person.id)", in: namespace)

            VStack(alignment: .leading, spacing: 3) {
                Text(person.fullName)
                    .font(.body.weight(.semibold))
                    .matchedGeometryEffect(id: "name-\(person.id)", in: namespace)

                if !person.role.isEmpty || !person.audience.isEmpty {
                    Text([person.role, person.audience].filter { !$0.isEmpty }.joined(separator: " · "))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                if !person.country.isEmpty {
                    Label(person.country, systemImage: "mappin")
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }
            }

            Spacer()

            if !person.level.isEmpty {
                Text(person.level)
                    .font(.caption2.weight(.bold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(person.levelColor.opacity(0.15))
                    .foregroundStyle(person.levelColor)
                    .clipShape(Capsule())
                    .matchedGeometryEffect(id: "level-\(person.id)", in: namespace)
            }
        }
        .padding(14)
        .background(.background, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: .black.opacity(0.04), radius: 2, y: 1)
        .padding(.vertical, 3)
    }
}

// MARK: - Avatar

struct AvatarView: View {
    let person: Person
    var size: CGFloat = 48

    var body: some View {
        Group {
            if let url = person.photoURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable().scaledToFill()
                    default:
                        initialsView
                    }
                }
            } else {
                initialsView
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }

    private var initialsView: some View {
        Circle()
            .fill(person.levelColor.opacity(0.2))
            .overlay {
                Text(person.initials)
                    .font(size > 50 ? .title2.weight(.semibold) : .subheadline.weight(.medium))
                    .foregroundStyle(person.levelColor)
            }
    }
}

// MARK: - Context Menu

struct PersonContextMenu: View {
    let person: Person

    var body: some View {
        Button { UIPasteboard.general.string = person.fullName } label: {
            Label("Copy Name", systemImage: "doc.on.doc")
        }
        if !person.level.isEmpty {
            Button { UIPasteboard.general.string = person.level } label: {
                Label("Copy Level", systemImage: "square.on.square")
            }
        }
        if !person.country.isEmpty {
            Button { UIPasteboard.general.string = person.country } label: {
                Label("Copy Location", systemImage: "mappin.circle")
            }
        }
    }
}

// MARK: - Detail Sheet

struct PersonDetailSheet: View {
    let person: Person
    var namespace: Namespace.ID
    var onDismiss: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture(perform: onDismiss)

            VStack(spacing: 0) {
                // Header
                VStack(spacing: 12) {
                    AvatarView(person: person, size: 80)
                        .matchedGeometryEffect(id: "avatar-\(person.id)", in: namespace)

                    Text(person.fullName)
                        .font(.title2.weight(.bold))
                        .matchedGeometryEffect(id: "name-\(person.id)", in: namespace)

                    if !person.track.isEmpty {
                        Text(person.track)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    if !person.level.isEmpty {
                        Text(person.level)
                            .font(.caption.weight(.bold))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 5)
                            .background(person.levelColor.opacity(0.15))
                            .foregroundStyle(person.levelColor)
                            .clipShape(Capsule())
                            .matchedGeometryEffect(id: "level-\(person.id)", in: namespace)
                    }
                }
                .padding(.top, 32)
                .padding(.bottom, 20)

                Divider()

                // Details
                VStack(spacing: 0) {
                    if !person.role.isEmpty {
                        detailRow(icon: "briefcase", label: "Role", value: person.role)
                    }
                    if !person.country.isEmpty {
                        detailRow(icon: "mappin.and.ellipse", label: "Location", value: person.country)
                    }
                    if !person.audience.isEmpty {
                        detailRow(icon: "person.2", label: "Audience", value: person.audience)
                    }
                }
                .padding(.vertical, 8)

                Spacer()

                Button("Done", action: onDismiss)
                    .font(.body.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
            }
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
            .padding(.horizontal, 16)
            .padding(.vertical, 60)
        }
        .accessibilityAddTraits(.isModal)
    }

    private func detailRow(icon: String, label: String, value: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.body)
                .foregroundStyle(.secondary)
                .frame(width: 28)
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.caption)
                    .foregroundStyle(.tertiary)
                Text(value)
                    .font(.body)
            }
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 10)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(label): \(value)")
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
