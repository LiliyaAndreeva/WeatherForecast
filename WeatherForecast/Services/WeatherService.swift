//
//  WeatherServise.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 13.05.2025.
//

import Foundation

protocol WeatherServiceProtocol {
	func fetchForecast(latitude: Double, longitude: Double, completion: @escaping (Result<ForecastWeatherResponse, Error>) -> Void)
	func fetchCurrentWeather(latitude: Double, longitude: Double, completion: @escaping (Result<CurrentWeatherResponse, Error>) -> Void)
}

final class WeatherService: WeatherServiceProtocol {
	
	private let networkManager: NetworkManagerProtocol

	init(networkManager: NetworkManagerProtocol) {
		self.networkManager = networkManager
	}
	
	func fetchForecast(latitude: Double, longitude: Double, completion: @escaping (Result<ForecastWeatherResponse, any Error>) -> Void) {
		let url = APIEndpoint.current(lat: latitude, lon: longitude).url
		networkManager.fetchData(url: url, completion: completion)
	}
	
	func fetchCurrentWeather(latitude: Double, longitude: Double, completion: @escaping (Result<CurrentWeatherResponse, any Error>) -> Void) {
		let url = APIEndpoint.forecast(lat: latitude, lon: longitude).url
		networkManager.fetchData(url: url, completion: completion)
	}

}
