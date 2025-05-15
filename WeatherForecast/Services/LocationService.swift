//
//  LocationService.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 13.05.2025.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol {
	func requestLocation(completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void)
}

final class LocationService: NSObject, CLLocationManagerDelegate, LocationServiceProtocol {
	private let locationManager = CLLocationManager()
	private var locationCompletion: ((Result<CLLocationCoordinate2D, Error>) -> Void)?

	override init() {
		super.init()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
		locationManager.pausesLocationUpdatesAutomatically = false
	}

	func requestLocation(completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
		locationCompletion = completion
		let status = CLLocationManager.authorizationStatus()
		if status == .notDetermined {
			locationManager.requestWhenInUseAuthorization()
		} else if status == .denied {
			let moscowCoordinate = CLLocationCoordinate2D(latitude: 55.7558, longitude: 37.6173)
			completion(.success(moscowCoordinate))
		} else {
			locationManager.startUpdatingLocation()
		}
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.last else { return }
		locationManager.stopUpdatingLocation()
		locationCompletion?(.success(location.coordinate))
		locationCompletion = nil
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		locationCompletion?(.failure(error))
		locationCompletion = nil
	}
}
