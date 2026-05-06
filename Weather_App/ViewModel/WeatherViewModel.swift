

import Foundation

@Observable
class WeatherViewModel {
    var city: String = ""
    var weather: WeatherModel?
    var isLoading: Bool = false
    var errorMessage: String?

    var showAlert: Bool = false

    //  MARK: API KEY

    private let apiKey = "4a8ee92841a54ff085b83204260605"

    // http://api.weatherapi.com/v1/current.json?key=4a8ee92841a54ff085b83204260605&q=Bengaluru&aqi=no

    func fetchWeatherData(for city: String) async throws -> WeatherModel {
        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(city)&aqi=no"

        guard let url = URL(string: urlString) else {
            throw WeatherError.invalidUrl
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw WeatherError.unknown
        }

        guard httpResponse.statusCode == 200 else {
            print(httpResponse.statusCode)
            showAlert = true
            throw WeatherError.requestFailed(statusCode: httpResponse.statusCode)
        }

        let decoder = JSONDecoder()

        do {
            return try decoder.decode(WeatherModel.self, from: data)
        } catch {
            throw WeatherError.decodingFailed
        }
    }

    @MainActor
    func fetch() async {
        do {
            weather = try await fetchWeatherData(for: city)
        } catch {
            if let weatherError = error as? WeatherError {
                errorMessage = weatherError.localizedDescription
            } else {
                errorMessage = "An unknown error occurred. \(error.localizedDescription)"
            }
        }
    }
}
