//
//  WeatherForecastModel.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 13.05.2025.

import Foundation

// MARK: - Root
struct CurrentWeatherResponse: Codable {
	let location: Location
	let current: CurrentWeather
}

// MARK: - Location
struct Location: Codable {
	let name: String
	let lat: Double
	let lon: Double
}

// MARK: - CurrentWeather
struct CurrentWeather: Codable {
	let tempC: Double
	let condition: Condition

	enum CodingKeys: String, CodingKey {
		case tempC = "temp_c"
		case condition
	}
}

// MARK: - Condition
struct Condition: Codable {
	let text: String
	let icon: String
	let code: Int
}
