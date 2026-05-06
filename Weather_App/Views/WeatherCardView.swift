import SwiftUI

struct WeatherCardView: View {
    let weatherModel: WeatherModel

    var urlString: String {
        "https:\(weatherModel.current.condition.icon)"
    }

    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: URL(string: urlString)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 90, height: 90)

            VStack(spacing: 4) {
                Text(weatherModel.location.name)
                    .font(.title2.bold())

                HStack {
                    Text("\(weatherModel.location.region),")
                    Text(weatherModel.location.country)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }

            Text("\(weatherModel.current.tempC, specifier: "%.0f")°C")
                .font(.system(size: 50, weight: .bold, design: .rounded))

            Text("Feels like \(weatherModel.current.feelslikeC, specifier: "%.0f")°C")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(weatherModel.current.condition.text)
                .font(.headline)
                .padding(.top, 4)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .strokeBorder(.white.opacity(0.2))
                )
        )
        .shadow(color: .black.opacity(0.15), radius: 15, x: 0, y: 8)
        .padding(.horizontal)
    }
}
