//
//  WeatherForecastViewModel.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 13.05.2025.
//

import Foundation

protocol WeatherForecastViewModelProtocol: AnyObject {
	var onDataUpdate: ((WeatherForecastDisplayModel) -> Void)? { get set }
	var onError: ((Error) -> Void)? { get set }
	
	func loadWeather()
}

final class WeatherForecastViewModel: WeatherForecastViewModelProtocol {

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

}

private extension WeatherForecastViewModel {
	private func mapToDisplayModel(from data: ForecastWeatherResponse) -> WeatherForecastDisplayModel {
		let cityName = data.location.name
		let currentTemperture = "\(Int(data.current.tempC))"
		let conditionDescribtion = data.current.condition.text
		let conditionIconURl = URL(string: "https: \(data.current.condition.icon)")
		let dailyForecasts = mapDailyForecasts(data.forecast.forecastday)
		let hourlyForecasts = mapHourlyForecasts(data.forecast.forecastday.first?.hour)

		return WeatherForecastDisplayModel(
			cityName: cityName,
			currentTemp: currentTemperture,
			conditionDescription: conditionDescribtion,
			conditionIconURL: conditionIconURl,
			dailyForecasts: dailyForecasts,
			hourlyForecasts: hourlyForecasts
		)
	}

	func mapDailyForecasts(_ days: [ForecastDay]) -> [WeatherForecastDisplayModel.DailyForecast] {
		return days.map { day in
			return WeatherForecastDisplayModel.DailyForecast(
				date: day.date,
				maxTemp: formatTemperature(day.day.maxtempC),
				minTemp: formatTemperature(day.day.mintempC),
				iconURL: buildIconURL(from: day.day.condition.icon)
			)
		}
	}

	func mapHourlyForecasts(_ hours: [HourlyForecast]?) -> [WeatherForecastDisplayModel.HourlyForecast] {
		guard let hours = hours else { return [] }

		return hours.map { hour in
			return WeatherForecastDisplayModel.HourlyForecast(
				time: formatHour(from: hour.time),
				temperature: formatTemperature(hour.tempC),
				iconURL: buildIconURL(from: hour.condition.icon)
			)
		}
	}

	func formatHour(from fullTimeString: String) -> String {
		let inputFormatter = DateFormatter()
		inputFormatter.dateFormat = "yyyy-MM-dd HH:mm"

		let outputFormatter = DateFormatter()
		outputFormatter.dateFormat = "HH:mm"

		if let date = inputFormatter.date(from: fullTimeString) {
			return outputFormatter.string(from: date)
		}
		return fullTimeString // fallback
	}

	func formatTemperature(_ temp: Double) -> String {
		return "\(Int(temp))"
	}
	
	func buildIconURL(from path: String) -> URL? {
		return URL(string: "https:\(path.trimmingCharacters(in: .whitespaces))")
	}
}

