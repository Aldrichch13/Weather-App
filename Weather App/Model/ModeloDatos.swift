//
//  ModeloDatos.swift
//  Weather App
//
//  Created by Aldrich  on 16/01/24.
//

import Foundation



struct WeatherData: Codable {
    let location: locationData
    let current: CurrentWeather
    let forecast: Forecast
}


struct CurrentWeather: Codable {
    let tempC: Double
    let condition: Condition
    let windKph: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
        case windKph = "wind_kph"
        case humidity
    }
}


struct Condition: Codable {
    let text: String
}


struct Forecast: Codable {
    let forecastday: [Forecastday]
}


struct Forecastday: Codable {
    let day: Day
    let astro: Astro
}


struct Astro: Codable {
    let sunrise, sunset: String
}


struct Day: Codable {
    let maxtempC: Float
    let mintempC: Float

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
    }
}

struct locationData: Codable {
    let name, region: String
}
