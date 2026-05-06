import SwiftUI

struct WeatherView: View {
    @State var weatherViewModel = WeatherViewModel()
    @State var darkMode: Bool = false

    @FocusState private var isFocusedState: Bool

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(.systemBackground),
                        Color(.secondarySystemBackground),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    VStack(spacing: 6) {
                        Text("Weather App")
                            .font(.largeTitle.bold())

                        Text("Check real-time weather in any city")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 10)

                    VStack(spacing: 15) {
                        TextField("Enter city name...", text: $weatherViewModel.city)
                            .focused($isFocusedState)
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.words)

                        Button {
                            Task {
                                isFocusedState = false
                                await weatherViewModel.fetch()
                            }
                        } label: {
                            HStack {
                                Spacer()
                                Text("Get Weather")
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [.blue, .cyan],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 5)
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.black.opacity(0.1), radius: 10)

                    Group {
                        if weatherViewModel.isLoading {
                            ProgressView()
                                .padding()

                        } else if let weather = weatherViewModel.weather {
                            WeatherCardView(weatherModel: weather)
                                .transition(.opacity.combined(with: .move(edge: .bottom)))

                        } else {
                            VStack(spacing: 8) {
                                Image(systemName: "cloud.sun.fill")
                                    .font(.system(size: 40))
                                    .foregroundStyle(.secondary)

                                Text("Search for a city to see weather")
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.top, 30)
                        }
                    }

                    Spacer()
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        darkMode.toggle()
                    } label: {
                        Image(systemName: darkMode ? "sun.max.fill" : "moon.fill")
                    }
                }
            }
        }
        .preferredColorScheme(darkMode ? .dark : .light)
        .alert(isPresented: $weatherViewModel.showAlert) {
            Alert(
                title: Text("Error").foregroundColor(.red).fontWeight(.bold),
                message: Text("City entered is wrong"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
