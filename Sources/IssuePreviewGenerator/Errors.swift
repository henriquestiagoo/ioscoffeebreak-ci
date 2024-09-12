import Foundation

enum Error: Swift.Error {
    case jsonFileNotFound
    case jsonBodyHasInvalidKeys
    case invalidImageData
    case imageCreationFailed
}
