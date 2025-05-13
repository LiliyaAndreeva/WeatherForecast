//
//  WeatherForecastBuilder.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 13.05.2025.
//

import UIKit

final class WeatherForecastModuleBuilder {
	static func build() -> UIViewController {
		let networkManager = NetworkManager.shared
		let weatherService = WeatherService(networkManager: networkManager)
		let locationService = LocationService()

		let viewModel = WeatherForecastViewModel(
			weatherService: weatherService,
			locationService: locationService
		)

		let viewController = WeatherForecastViewController(viewModel: viewModel)
		return viewController
	}
}
