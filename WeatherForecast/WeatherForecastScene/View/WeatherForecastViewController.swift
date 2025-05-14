//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 13.05.2025.
//

import UIKit
import CoreLocation

class WeatherForecastViewController: UIViewController {
	// MARK: - Dependencies
	private let viewModel: WeatherForecastViewModelProtocol
	private let forecastView = WeatherForecastView()

	init(viewModel: WeatherForecastViewModelProtocol) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecircle
	
	override func loadView() {
		view = forecastView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		bindViewModel()
		forecastView.activityIndicator.startAnimating()
		viewModel.loadWeather()
	}


}

private extension WeatherForecastViewController {
	func bindViewModel() {
		viewModel.onDataUpdate = { [weak self] model in
			DispatchQueue.main.async {
				self?.forecastView.cityNameLabel.text = model.cityName
				self?.forecastView.temperatureLabel.text = model.currentTemp
				self?.forecastView.weatherDescribtionLabel.text = model.conditionDescription

				if let url = model.conditionIconURL {
					// Можно подключить библиотеку вроде SDWebImage или использовать простую загрузку
				}

				self?.forecastView.activityIndicator.stopAnimating()
			}
		}

		viewModel.onError = { [weak self] error in
			DispatchQueue.main.async {
				self?.forecastView.activityIndicator.stopAnimating()
				// показать алерт и т.д.
			}
		}
	}
}


