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
            if index == 0 { continue }
            let fields = parseCSVLine(line)
            guard fields.count >= 7 else { continue }
            let name = fields[0].trimmingCharacters(in: .whitespaces)
            guard !name.isEmpty else { continue }

            let photoField = fields[1].trimmingCharacters(in: .whitespaces)
            var photoURL: URL?
            if let range = photoField.range(of: "(http"),
               let endRange = photoField.range(of: ")", range: range.lowerBound..<photoField.endIndex) {
                let urlString = String(photoField[photoField.index(after: range.lowerBound)..<endRange.lowerBound])
                photoURL = URL(string: urlString)
            }

            // Use name + row index to ensure unique IDs even with duplicate names
            let uniqueId = "\(name)-\(index)"

            people.append(Person(
                id: uniqueId,
                fullName: name,
                photoURL: photoURL,
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
        var chars = Array(line)
        var i = 0

        while i < chars.count {
            let char = chars[i]
            if inQuotes {
                if char == "\"" {
                    // Check if next char is also a quote (escaped quote)
                    if i + 1 < chars.count && chars[i + 1] == "\"" {
                        current.append("\"")
                        i += 2 // Skip both quotes
                        continue
                    } else {
                        inQuotes = false
                    }
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
            i += 1
        }
        fields.append(current)
        return fields
    }
}
