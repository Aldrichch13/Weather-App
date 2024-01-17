//
//  APIRequest.swift
//  Weather App
//
//  Created by Aldrich  on 16/01/24.
//

import Foundation
import CoreLocation


class WeatherViewModel:NSObject, ObservableObject {
    @Published var weatherData: WeatherData?

    private let apiURL = "https://api.weatherapi.com/v1/forecast.json"
    private let apiKey = "47470cb8e4c44fbba04164723241601"

    private var locationManager = CLLocationManager()

    
    override init() {
        super.init()
        self.setupLocationManager()
    }

    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    func fetchWeatherData(latitude: Double, longitude: Double) {
        let urlString = "\(apiURL)?key=\(apiKey)&q=\(latitude),\(longitude)&days=1&aqi=no&alerts=no"
        print(latitude)
        print(urlString)

        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(WeatherData.self, from: data)
                        DispatchQueue.main.async {
                            self.weatherData = result
                        }
                    } catch {
                        print("No se completo la peticion")
                    }
                }
            }.resume()
        }
    }
}

extension WeatherViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            fetchWeatherData(latitude: latitude, longitude: longitude)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
