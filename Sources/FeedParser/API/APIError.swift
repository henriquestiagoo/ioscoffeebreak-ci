import Foundation

enum APIError: LocalizedError, Equatable {
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.custom(let lhsError), .custom(let rhsRrror)):
            return lhsError.localizedDescription == rhsRrror.localizedDescription
        case (.failedToDecode, .failedToDecode):
            return true
        case (.invalidContent, .invalidContent):
            return true
        case (.invalidStatusCode(let lhsStatusCode), .invalidStatusCode(let rhsStatusCode)):
            return lhsStatusCode == rhsStatusCode
        case (.invalidUrl, .invalidUrl):
            return true
        default:
            return false
        }
    }

    case custom(error: Error)
    case failedToDecode
    case invalidContent
    case invalidStatusCode(statusCode: Int)
    case invalidUrl

    var errorDescription: String? {
        switch self {
        case .custom(let error):
            return String(localized: "Something went wrong: \(error.localizedDescription).")
        case .failedToDecode:
            return String(localized: "Failed to decode.")
        case .invalidContent:
            return String(localized: "Invalid content.")
        case .invalidStatusCode(let statusCode):
            return String(localized: "Status code falls into the wrong range: \(statusCode).")
        case .invalidUrl:
            return String(localized: "URL is not valid.")
        }
    }
}
