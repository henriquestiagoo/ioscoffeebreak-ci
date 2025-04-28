import Foundation

class APIClient {
    private let session: URLSession = .shared

    private let decoder: JSONDecoder = {
        let isoDateFormatter = ISO8601DateFormatter()
        // Insert .withFractionalSeconds to the current format.
        isoDateFormatter.formatOptions.insert(.withFractionalSeconds)
        let decoder = JSONDecoder()
        // https://www.donnywals.com/working-with-dates-and-codable-in-swift/
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            if let date = isoDateFormatter.date(from: dateString) {
                return date
            } else {
                throw APIError.failedToDecode
            }
        }
        return decoder
    }()

    func getIssues() async throws -> [Issue] {
        guard let url = URL(string: Constants.API.feed) else { throw APIError.invalidUrl }
        let request = URLRequest(url: url)
        let (data, response) = try await session.data(for: request)
        guard let response = response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
            throw APIError.invalidStatusCode(statusCode: statusCode)
        }
        let issuesResponse = try decoder.decode(IssuesResponse.self, from: data)
        return issuesResponse.issues
    }
}
