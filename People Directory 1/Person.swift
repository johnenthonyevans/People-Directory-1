//
//  Person.swift
//  People Directory 1
//

import Foundation

struct Person: Identifiable, Hashable {
    let id = UUID()
    let fullName: String
    let track: String
    let level: String
    let role: String
    let country: String
    let audience: String

    var initials: String {
        let parts = fullName.split(separator: " ").filter { !$0.hasPrefix("[") }
        if parts.count >= 2, let first = parts.first?.first, let last = parts.last?.first {
            return "\(first)\(last)".uppercased()
        }
        return String(fullName.prefix(2)).uppercased()
    }
}
