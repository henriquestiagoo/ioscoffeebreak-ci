import Foundation

struct Issue: Hashable, Codable, Identifiable {
    var id: String
    var content: String
    var url: String
    var title: String
    var summary: String
    var date: Date
    var tags: [String]

    enum CodingKeys: String, CodingKey {
        case id, url, title, summary, tags
        case content = "content_html"
        case date = "date_modified"
    }
}

extension Issue {
    var markdown: String { "* [Issue #\(id): \(title)](\(url))" }
}
