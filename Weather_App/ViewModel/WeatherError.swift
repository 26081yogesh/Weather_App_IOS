import Foundation

// MARK: Enums for Error

enum WeatherError: LocalizedError {
    case invalidUrl
    case requestFailed(statusCode: Int)
    case decodingFailed
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case let .requestFailed(statusCode):
            return "Request failed with status code: \(statusCode)"
        case .decodingFailed:
            return "Decoding failed"
        case .unknown:
            return "Unknown error"
        }
    }
}
