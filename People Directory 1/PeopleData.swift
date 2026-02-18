//
//  PeopleData.swift
//  People Directory 1
//

import Foundation

enum PeopleData {
    static func load() -> [Person] {
        guard let url = Bundle.main.url(forResource: "people", withExtension: "csv"),
              let raw = try? String(contentsOf: url, encoding: .utf8) else {
            return []
        }
        return parseCSV(raw)
    }

    private static func parseCSV(_ raw: String) -> [Person] {
        var people: [Person] = []
        let lines = raw.components(separatedBy: .newlines)
        guard lines.count > 1 else { return people }

        for (index, line) in lines.enumerated() {
            if index == 0 { continue } // skip header
            let fields = parseCSVLine(line)
            guard fields.count >= 7 else { continue }
            let name = fields[0].trimmingCharacters(in: .whitespaces)
            guard !name.isEmpty else { continue }
            people.append(Person(
                fullName: name,
                track: fields[2].trimmingCharacters(in: .whitespaces),
                level: fields[3].trimmingCharacters(in: .whitespaces),
                role: fields[4].trimmingCharacters(in: .whitespaces),
                country: fields[5].trimmingCharacters(in: .whitespaces),
                audience: fields[6].trimmingCharacters(in: .whitespaces)
            ))
        }
        return people
    }

    private static func parseCSVLine(_ line: String) -> [String] {
        var fields: [String] = []
        var current = ""
        var inQuotes = false
        for char in line {
            if inQuotes {
                if char == "\"" {
                    inQuotes = false
                } else {
                    current.append(char)
                }
            } else {
                if char == "\"" {
                    inQuotes = true
                } else if char == "," {
                    fields.append(current)
                    current = ""
                } else {
                    current.append(char)
                }
            }
        }
        fields.append(current)
        return fields
    }
}
