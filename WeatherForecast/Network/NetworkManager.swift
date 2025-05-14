//
//  NetworkManager.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 13.05.2025.
//

import Foundation



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
				print("❌ Decoding error:", error)
				completion(.failure(error))
//				if let decodingError = error as? DecodingError {
//					switch decodingError {
//					case .keyNotFound(let key, let context):
//						print("🔑 Missing key:", key.stringValue)
//						print("📍 CodingPath:", context.codingPath)
//					case .typeMismatch(let type, let context):
//						print("❌ Type mismatch:", type)
//						print("📍 Context:", context)
//					case .valueNotFound(let type, let context):
//						print("❌ Value not found for type:", type)
//						print("📍 Context:", context)
//					case .dataCorrupted(let context):
//						print("❌ Data corrupted:", context)
//					default:
//						break
//					}
//				}
			}
		}
		
		task.resume()
	}
}
