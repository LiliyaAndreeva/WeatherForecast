//
//  NetworkManager.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 13.05.2025.
//

import Foundation



//public enum APIEndpoint {
//	case weather(latitude: Double, longitude: Double)
//	
//	public var url: URL {
//		switch self {
//		case .weather(let latitude, let longitude):
//			let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=5034db7366ec3e2f7831435eca9e2bad"
//			return URL(string: urlString)!
//		}
//	}
//}


public protocol NetworkManagerProtocol {
	func fetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

public final class NetworkManager: NetworkManagerProtocol{

	static let shared = NetworkManager()

	private init() {}

	public func fetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
		let session = URLSession.shared
		
		let task = session.dataTask(with: url) { (data, response, error) in
			guard error == nil else {
				completion(.failure(error!))
				return
			}
			guard let data = data else {
				let dataError = NSError(domain: "NetworkManager",
										code: -2,
										userInfo: [NSLocalizedDescriptionKey: "No data returned"])
				DispatchQueue.main.async {
					completion(.failure(dataError))
				}
				return
			}
			
			do {
				let decodedData = try JSONDecoder().decode(T.self, from: data)
				completion(.success(decodedData))
			} catch {
				completion(.failure(error))
				print(error)
			}
		}
		
		task.resume()
	}
}
