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
	public let locationManager = CLLocationManager()
	public var weatherData = WeatherData()
	public let networkManager = NetworkManager.shared
	
	// MARK: - Private properties
	private lazy var backgroundImageView: UIImageView = setupBackgroundImageView()
	private lazy var cityNameView: UILabel = setupCityNameLabel()
	private lazy var tempertureLabel: UILabel = setupTempertureLabel()
	private lazy var weatherDescribtionLabel: UILabel = setupweatherDescribtionLabel()
	private lazy var activityIndicator: UIActivityIndicatorView = setupActivityIndicator()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .purple
		setupView()
		startLocationManager()
	}


}

// MARK: - Settings View
extension WeatherForecastViewController {
	func setupView(){
		addSubView()
		setupLayout()
		showActivityIndicator()
	}
}

// MARK: - Settings
extension WeatherForecastViewController {
	func addSubView(){
		[
			backgroundImageView,
			cityNameView,
			tempertureLabel,
			weatherDescribtionLabel,
			activityIndicator
		].forEach { subViews in
			view.addSubview(subViews)
		}
	}

	func setupBackgroundImageView() -> UIImageView {
		let backgroundImageView = UIImageView()
		backgroundImageView.frame = view.bounds
		backgroundImageView.contentMode = .scaleAspectFill
		backgroundImageView.clipsToBounds = true
		backgroundImageView.image = UIImage(named: SizesAndStrings.strings.imageName)
		//backgroundImageView.image = UIImage(named: SizesAndStrings.strings.imageName, in: Bundle.module, compatibleWith: nil)
		return backgroundImageView
	}

	func setupCityNameLabel() -> UILabel {
		let cityLabel = UILabel()
		cityLabel.textColor = .white
		cityLabel.font = .systemFont(ofSize: SizesAndStrings.fontSizes.double, weight: .bold)
		return cityLabel
	}

	func setupTempertureLabel() -> UILabel {
		let tempertureLabel = UILabel()
		tempertureLabel.textColor = .white
		tempertureLabel.font = .systemFont(ofSize: SizesAndStrings.fontSizes.normal, weight: .bold)
		return tempertureLabel
	}

	func setupweatherDescribtionLabel() -> UILabel {
		let weatherDescribtionLabel = UILabel()
		weatherDescribtionLabel.textColor = .white
		weatherDescribtionLabel.font = .systemFont(ofSize: SizesAndStrings.fontSizes.normal, weight: .bold)
		return weatherDescribtionLabel
	}

	func setupActivityIndicator() -> UIActivityIndicatorView {
		let indicator = UIActivityIndicatorView()
		indicator.color = .white
		indicator.hidesWhenStopped = true
		return indicator
	}

	func showActivityIndicator() {
		activityIndicator.startAnimating()
	}
}

// MARK: - Layout
extension WeatherForecastViewController {
	func setupLayout() {

		[cityNameView, tempertureLabel, weatherDescribtionLabel, activityIndicator ].forEach { view in
			view.translatesAutoresizingMaskIntoConstraints = false
		}

		NSLayoutConstraint.activate(
			[
				cityNameView.topAnchor.constraint(equalTo: view.topAnchor, constant: thirdOfTheScreenWidth),
				cityNameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
				activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
				activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
				tempertureLabel.topAnchor.constraint(
					equalTo: cityNameView.bottomAnchor,
					constant: distance
				),
				tempertureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
				weatherDescribtionLabel.topAnchor.constraint(
					equalTo: tempertureLabel.bottomAnchor,
					constant: distance
				),
				weatherDescribtionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
			]
		)
	}
	
	var thirdOfTheScreenWidth: Double {
		return view.frame.width / 3.0
	}
	
	var distance: Double {
		return view.frame.width * 0.2
	}
}


// MARK: - CLLocationManagerDelegate
extension WeatherForecastViewController: CLLocationManagerDelegate {
	public func startLocationManager() {

		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
		locationManager.pausesLocationUpdatesAutomatically = false
		locationManager.startUpdatingLocation()
	}

	public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let lastlocation = locations.last {
			updateCoordinates(latitude: lastlocation.coordinate.latitude, longitude: lastlocation.coordinate.longitude)
		}
	}

	public func updateCoordinates(latitude: Double, longitude: Double) {

		let endpoint = APIEndpoint.weather(latitude: latitude, longitude: longitude)

		networkManager.fetchData(url: endpoint.url) { [weak self] (result: Result<WeatherData, Error>) in
			guard let self = self else { return }
			switch result {
			case .success(let weatherData):
				self.weatherData = weatherData

				DispatchQueue.main.async {
					self.updateView()
				}
			case .failure(let error):
				print(SizesAndStrings.strings.errorfetching, error.localizedDescription)
			}
		}
	}


	public func updateView() {
		cityNameView.text = weatherData.name
		//weatherDescribtionLabel.text = DataSource.weatherIDs[weatherData.weather[0].id]

		let tempInFahrenheit = weatherData.main.temp
		let tempInCelsius = Int(tempInFahrenheit -  SizesAndStrings.farenheitTemp)
		tempertureLabel.text = "\(tempInCelsius)" + SizesAndStrings.strings.celcies
		activityIndicator.stopAnimating()
	}
}
