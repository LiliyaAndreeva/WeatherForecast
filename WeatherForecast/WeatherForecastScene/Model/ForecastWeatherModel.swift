//
//  ForecastWeather.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 13.05.2025.
//

import Foundation

// MARK: - ForecastWeatherResponse
struct ForecastWeatherResponse: Codable {
	let location: Location
	let current: CurrentWeather
	let forecast: Forecast
}

// MARK: - Forecast
struct Forecast: Codable {
	let forecastday: [ForecastDay]
}

// MARK: - ForecastDay
struct ForecastDay: Codable {
	let date: String
	let dateEpoch: Int
	let day: Day
	let hour: [HourlyForecast]

	enum CodingKeys: String, CodingKey {
		case date
		case dateEpoch = "date_epoch"
		case day
		case hour
	}
}

// MARK: - Day (daily summary)
struct Day: Codable {
	let maxtempC: Double
	let mintempC: Double
	let condition: Condition

	enum CodingKeys: String, CodingKey {
		case maxtempC = "maxtemp_c"
		case mintempC = "mintemp_c"
		case condition
	}
}


// MARK: - HourlyForecast
struct HourlyForecast: Codable {
	let timeEpoch: Int
	let time: String
	let tempC: Double
	let isDay: Int
	let condition: Condition

	enum CodingKeys: String, CodingKey {
		case timeEpoch = "time_epoch"
		case time
		case tempC = "temp_c"
		case isDay = "is_day"
		case condition
	}
}
