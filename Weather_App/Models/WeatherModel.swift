
import Foundation

// MARK: - WeatherModel

struct WeatherModel: Codable {
    let location: Location
    let current: Current
}

// MARK: - Current

struct Current: Codable {
    let tempC: Double
    let condition: Condition
    let windKph: Double
    let feelslikeC: Double

    // MARK: Coding Keys

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
        case windKph = "wind_kph"
        case feelslikeC = "feelslike_c"
    }
}

// MARK: - Condition

struct Condition: Codable {
    let text: String
    let icon: String
}

// MARK: - Location

struct Location: Codable {
    let name: String
    let country: String
    let region: String
}
