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
		
		let status: CLAuthorizationStatus
		if #available(iOS 14.0, *) {
			status = locationManager.authorizationStatus
		} else {
			status = CLLocationManager.authorizationStatus()
		}
		
		switch status {
		case .notDetermined:
			locationManager.requestWhenInUseAuthorization()
		case .denied, .restricted:
			let moscowCoordinate = CLLocationCoordinate2D(latitude: 55.7558, longitude: 37.6173)
			completion(.success(moscowCoordinate))
		case .authorizedAlways, .authorizedWhenInUse:
			locationManager.startUpdatingLocation()
		default:
			break
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
	
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		let status: CLAuthorizationStatus
		if #available(iOS 14.0, *) {
			status = manager.authorizationStatus
		} else {
			status = CLLocationManager.authorizationStatus()
		}
		
		switch status {
		case .authorizedWhenInUse, .authorizedAlways:
			locationManager.startUpdatingLocation()
		case .denied, .restricted:
			let moscowCoordinate = CLLocationCoordinate2D(latitude: 55.7558, longitude: 37.6173)
			locationCompletion?(.success(moscowCoordinate))
			locationCompletion = nil
		default:
			break
		}
	}
}
