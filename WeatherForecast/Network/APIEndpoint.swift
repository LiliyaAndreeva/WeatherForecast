//
//  ApiEndpoints.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 13.05.2025.
//

import Foundation
enum APIEndpoint {
	case current(lat: Double, lon: Double)
	case forecast(lat: Double, lon: Double)

	var url: URL {
		let key = "680bedb005bd443cb46154008251605"
		switch self {
		case .current(let lat, let lon):
			return URL(string: "https://api.weatherapi.com/v1/current.json?key=\(key)&q=\(lat),\(lon)&lang=ru")!
		case .forecast(let lat, let lon):
			return URL(string: "https://api.weatherapi.com/v1/forecast.json?key=\(key)&q=\(lat),\(lon)&days=7&lang=ru")!
		}
	}
}
