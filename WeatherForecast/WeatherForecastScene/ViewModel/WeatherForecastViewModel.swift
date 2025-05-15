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
	func loadWeather2()
}

final class WeatherForecastViewModel: WeatherForecastViewModelProtocol {

	private let weatherService: WeatherServiceProtocol
	private let locationService: LocationServiceProtocol

	var hourlyWeather: [WeatherForecastDisplayModel.HourlyForecast] = []
	var dailyWeather: [WeatherForecastDisplayModel.DailyForecast] = []
	var onHourlyUpdate: (() -> Void)?
	var onDailyUpdate: (() -> Void)?
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
							
							self?.hourlyWeather = displayModel!.hourlyForecasts
							self?.onHourlyUpdate?()
							self?.dailyWeather = displayModel!.dailyForecasts
							self?.onDailyUpdate?()
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
	
	func loadWeather2() {
		locationService.requestLocation { [weak self] location in
			switch location {
			case .success(let coordinates):
				let group = DispatchGroup()
				var forecastData: ForecastWeatherResponse?
				var currentData: CurrentWeatherResponse?
				var fetchError: Error?
				
				group.enter()
				self?.weatherService.fetchForecast(
					latitude: coordinates.latitude,
					longitude: coordinates.longitude
				) { result in
					defer { group.leave() }
					switch result {
					case .success(let data):
						forecastData = data
					case .failure(let error):
						fetchError = error
					}
				}
				group.enter()
				self?.weatherService.fetchCurrentWeather(
					latitude: coordinates.latitude,
					longitude: coordinates.longitude
				) { result in
					defer { group.leave()}
					switch result {
					case .success(let data):
						currentData = data
					case .failure(let error):
						fetchError = error
					}
						
					}
				
				group.notify(queue: .main) {
					guard fetchError == nil else { self?.onError?(fetchError!)
						return
					}
					
					guard let forecast = forecastData, let current = currentData else { return }
					
					let displayModel = self?.mapToDisplayModel(forecast: forecast, current: current)
					self?.onDataUpdate?(displayModel!)
					
					self?.hourlyWeather = displayModel!.hourlyForecasts
					self?.onHourlyUpdate?()
					self?.dailyWeather = displayModel!.dailyForecasts
					self?.onDailyUpdate?()
				}
			case .failure(let error):
				self?.onError?(error)
			}
			
		}
	}
}

private extension WeatherForecastViewModel {
	func mapToDisplayModel(forecast: ForecastWeatherResponse, current: CurrentWeatherResponse) -> WeatherForecastDisplayModel {
		let cityName = current.location.name
		let currentTemperture = "\(Int(current.current.tempC)) C°"
		let conditionDescribtion = current.current.condition.text
		let conditionIconURl = URL(string: "https: \(current.current.condition.icon)")
		
		let dailyForecasts = mapDailyForecasts(forecast.forecast.forecastday)
		let hourlyForecasts = mapHourlyForecasts(forecast.forecast.forecastday)

		return WeatherForecastDisplayModel(
			cityName: cityName,
			currentTemp: currentTemperture,
			conditionDescription: conditionDescribtion,
			conditionIconURL: conditionIconURl,
			dailyForecasts: dailyForecasts,
			hourlyForecasts: hourlyForecasts
		)
	}
	
	
	
	func mapToDisplayModel(from data: ForecastWeatherResponse) -> WeatherForecastDisplayModel {
		
		let cityName = data.location.name
		let currentTemperture = "\(Int(data.current.tempC)) C°"
		let conditionDescribtion = data.current.condition.text
		let conditionIconURl = URL(string: "https: \(data.current.condition.icon)")
		let dailyForecasts = mapDailyForecasts(data.forecast.forecastday)
		let hourlyForecasts = mapHourlyForecasts(data.forecast.forecastday)

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
		let today = Date()
		return days.map { day in
			let date = Date(timeIntervalSince1970: TimeInterval(day.dateEpoch))
			return WeatherForecastDisplayModel.DailyForecast(
				date: date.formattedDayOfWeek(referenceDate: today),
				maxTemp: formatTemperature(day.day.maxtempC),
				minTemp: formatTemperature(day.day.mintempC),
				iconURL: buildIconURL(from: day.day.condition.icon)
			)
		}
	}

	func mapHourlyForecasts(_ forecastDays: [ForecastDay]) -> [WeatherForecastDisplayModel.HourlyForecast] {
		let calendar = Calendar.current
		let now = calendar.date(bySettingHour: Calendar.current.component(.hour, from: Date()), minute: 0, second: 0, of: Date()) ?? Date()
		var result: [WeatherForecastDisplayModel.HourlyForecast] = []
		
		for (index, day) in forecastDays.prefix(2).enumerated() {
			for hour in day.hour {
				guard let hourDate = parseHourDate(from: hour.time) else { continue }
				
				if index == 0 {
					if hourDate >= now {
						result.append(mapHourForecast(hour))
					}
				} else {
					result.append(mapHourForecast(hour))
				}
			}
		}
		return result
	}
	
	func mapHourForecast(_ hour: HourlyForecast) -> WeatherForecastDisplayModel.HourlyForecast {
		return WeatherForecastDisplayModel.HourlyForecast(
			time: formatHour(from: hour.time),
			temperature: formatTemperature(hour.tempC),
			iconURL: buildIconURL(from: hour.condition.icon)
		)
	}

	func formatHour(from fullTimeString: String) -> String {
		let inputFormatter = DateFormatter()
		inputFormatter.dateFormat = "yyyy-MM-dd HH:mm"

		let outputFormatter = DateFormatter()
		outputFormatter.dateFormat = "HH:mm"

		if let date = inputFormatter.date(from: fullTimeString) {
			return outputFormatter.string(from: date)
		}
		return fullTimeString 
	}
	private func parseHourDate(from string: String) -> Date? {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm"
		formatter.locale = Locale(identifier: "en_US_POSIX")
		return formatter.date(from: string)
	}

	func formatTemperature(_ temp: Double) -> String {
		return "\(Int(temp))"
	}
	
	func buildIconURL(from path: String) -> URL? {
		return URL(string: "https:\(path.trimmingCharacters(in: .whitespaces))")
	}
}

