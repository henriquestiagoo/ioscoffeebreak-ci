import Foundation

struct IssuesResponse: Codable {
    let title: String
    let homePageUrl: String
    let description: String
    let issues: [Issue]

    enum CodingKeys: String, CodingKey {
        case title
        case homePageUrl = "home_page_url"
        case description
        case issues = "items"
    }
}
