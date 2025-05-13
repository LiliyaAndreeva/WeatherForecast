//
//  WeatherForecastViewModel.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 13.05.2025.
//

import Foundation

final class WeatherForecastViewModel {

	private let weatherService: WeatherServiceProtocol
	private let locationService: LocationServiceProtocol

	var onDataUpdate: ((WeatherForecastDisplayModel) -> Void)?
	var onError: ((Error) -> Void)?

	init(weatherService: WeatherServiceProtocol, locationService: LocationServiceProtocol) {
		self.weatherService = weatherService
		self.locationService = locationService
	}

	func loadWeather() {
		locationService.requestLocation { [weak self] result in
			switch result {
			case .success(let coordinates):
				self?.weatherService.fetchForecast(
					latitude: coordinates.latitude,
					longitude: coordinates.longitude
				) { weatherResult in
					DispatchQueue.main.async {
						switch weatherResult {
						case .success(let data):
							let displayModel = self?.mapToDisplayModel(from: data)
							self?.onDataUpdate?(displayModel!)
						case .failure(let error):
							self?.onError?(error)
						}
					}
				}
			case .failure(let error):
				self?.onError?(error)
			}
		}
	}

	private func mapToDisplayModel(from data: ForecastWeatherResponse) -> WeatherForecastDisplayModel {
		// Преобразование в UI-friendly модель
		let weatherForecastDisplayModel = WeatherForecastDisplayModel()
		return weatherForecastDisplayModel
	}
}

struct WeatherForecastDisplayModel {
	
}
