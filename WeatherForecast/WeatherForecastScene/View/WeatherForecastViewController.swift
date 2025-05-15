//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 13.05.2025.
//

import UIKit
import Kingfisher

class WeatherForecastViewController: UIViewController {
	// MARK: - Dependencies
	private let viewModel: WeatherForecastViewModelProtocol
	private let forecastView = WeatherForecastView()
	
	// MARK: - Private properties
	private var hourlyForecasts: [WeatherForecastDisplayModel.HourlyForecast] = []
	private var dailyForecasts: [WeatherForecastDisplayModel.DailyForecast] = []

	// MARK: - Initialization
	init(viewModel: WeatherForecastViewModelProtocol) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle
	override func loadView() {
		view = forecastView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		bindViewModel()
		forecastView.activityIndicator.startAnimating()
		viewModel.loadWeather2()
		setupCollctionView()
		setupVerticalCollectionView()
	}
}

// MARK: - Private extension
private extension WeatherForecastViewController {
	func bindViewModel() {
		viewModel.onDataUpdate = { [weak self] model in
			DispatchQueue.main.async {
				self?.update(with: model)
				self?.hourlyForecasts = model.hourlyForecasts
				self?.dailyForecasts = model.dailyForecasts
				self?.forecastView.hourlyCollectionView.reloadData()
				self?.forecastView.dailyCollectionView.reloadData()
				if let url = model.conditionIconURL {
					//forecastView.weatherDescribtionLabel.
				}
				//self?.forecastView.activityIndicator.stopAnimating()
			}
		}

		viewModel.onError = { [weak self] error in
			DispatchQueue.main.async {
				self?.forecastView.activityIndicator.stopAnimating()
				self?.showRetryAlert(message: error.localizedDescription) {
					self?.forecastView.activityIndicator.startAnimating()
					self?.viewModel.loadWeather()
				}
			}
		}
	}

	func setupVerticalCollectionView() {
		forecastView.dailyCollectionView.dataSource = self
		forecastView.dailyCollectionView.register(
			WeatherForecastCell.self,
			forCellWithReuseIdentifier: WeatherForecastCell.reuseIdentifier
		)
	}

	func setupCollctionView() {
		forecastView.hourlyCollectionView.dataSource = self
		forecastView.hourlyCollectionView.register(
			HourlyWeatherCell.self,
			forCellWithReuseIdentifier: HourlyWeatherCell.reuseIdentifier
		)
	}

	func showRetryAlert(message: String, retryAction: @escaping () -> Void) {
		let alert = UIAlertController(
			title: ConstantStrings.error,
			message: message,
			preferredStyle: .alert
		)

		alert.addAction(UIAlertAction(title: ConstantStrings.cancel, style: .cancel))
		alert.addAction(UIAlertAction(title: ConstantStrings.retry, style: .default) { _ in
			retryAction()
		})

		present(alert, animated: true)
	}
	
	func update(with model: WeatherForecastDisplayModel) {
		forecastView.cityNameLabel.text = model.cityName
		forecastView.temperatureLabel.text = model.currentTemp
		forecastView.weatherDescribtionLabel.text = model.conditionDescription
		forecastView.hourlyCollectionView.isHidden = false
		forecastView.dailyCollectionView.isHidden = false
		forecastView.activityIndicator.stopAnimating()
	}
}

// MARK: - Private UICollectionViewDataSource
extension WeatherForecastViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if collectionView == forecastView.hourlyCollectionView {
			return hourlyForecasts.count
		} else if collectionView == forecastView.dailyCollectionView {
			return dailyForecasts.count
		}
		return 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if collectionView == forecastView.hourlyCollectionView {
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.reuseIdentifier, for: indexPath) as? HourlyWeatherCell else {
				return UICollectionViewCell()
			}

			let forecastItem = hourlyForecasts[indexPath.item]
			cell.configure(with: forecastItem)

			if let url = forecastItem.iconURL {
				cell.iconImageView.kf.setImage(with: url)
			}
			return cell
		} else if collectionView == forecastView.dailyCollectionView {
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherForecastCell.reuseIdentifier, for: indexPath) as? WeatherForecastCell else {
				return UICollectionViewCell()
			}
			
			let forecastItem = dailyForecasts[indexPath.item]
			cell.configure(with: forecastItem)
			if let url = forecastItem.iconURL {
				cell.weatherIconImageView.kf.setImage(with: url)
			}
			return cell
		}
		return UICollectionViewCell()
	}
}


