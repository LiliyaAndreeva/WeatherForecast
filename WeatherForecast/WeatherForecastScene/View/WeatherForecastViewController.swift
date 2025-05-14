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
	private var hourlyForecasts: [WeatherForecastDisplayModel.HourlyForecast] = []
	
	init(viewModel: WeatherForecastViewModelProtocol) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - LifeСircle
	
	override func loadView() {
		view = forecastView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		bindViewModel()
		forecastView.activityIndicator.startAnimating()
		viewModel.loadWeather()
		setupCollctionView()
		
	}


}

private extension WeatherForecastViewController {
	func bindViewModel() {
		viewModel.onDataUpdate = { [weak self] model in
			DispatchQueue.main.async {
				self?.forecastView.cityNameLabel.text = model.cityName
				self?.forecastView.temperatureLabel.text = model.currentTemp
				self?.forecastView.weatherDescribtionLabel.text = model.conditionDescription
				self?.hourlyForecasts = model.hourlyForecasts
				self?.forecastView.hourlyCollectionView.reloadData()
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
	
	func setupCollctionView() {
		forecastView.hourlyCollectionView.dataSource = self
		forecastView.hourlyCollectionView.delegate = self
		forecastView.hourlyCollectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: HourlyWeatherCell.reuseIdentifier)
	}
}


extension WeatherForecastViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return hourlyForecasts.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.reuseIdentifier, for: indexPath) as? HourlyWeatherCell else {
					return UICollectionViewCell()
				}
		
		let forecastItem = hourlyForecasts[indexPath.item]
		cell.configure(
			time: forecastItem.time,
			temp: forecastItem.temperature,
			icon: UIImage(systemName: "star")
		)
		return cell
	}
	
	
}
extension WeatherForecastViewController: UICollectionViewDelegate {
	
}

