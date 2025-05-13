//
//  SceneDelegate.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 13.05.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
	
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)
		let weatherForecastViewController = WeatherForecastViewController()
		
		window.rootViewController = weatherForecastViewController
		window.makeKeyAndVisible()

		self.window = window
	}
}

