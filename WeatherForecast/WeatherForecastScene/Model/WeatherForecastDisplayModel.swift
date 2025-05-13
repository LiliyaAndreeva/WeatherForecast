//
//  WeatherForecastDisplayModel.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 13.05.2025.
//

import Foundation
struct WeatherForecastDisplayModel {
	let cityName: String
	let currentTemp: String
	let conditionDescription: String
	let conditionIconURL: URL?
	let dailyForecasts: [DailyForecast]
	let hourlyForecasts: [HourlyForecast]

	struct DailyForecast {
		let date: String
		let maxTemp: String
		let minTemp: String
		let iconURL: URL?
	}
	struct HourlyForecast {
		let time: String
		let temperature: String
		let iconURL: URL?
	}
}
