import Foundation

public struct GitHubIssue: Codable {
    public let number: Int
    public let state: String
    public let body: String
    public let title: String
}

struct Issue: Codable {
    let title: String
    let number: Int
}
