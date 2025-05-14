//
//  Sizes.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 13.05.2025.
//

import Foundation
enum SizesAndStrings {
	static let alpha: CGFloat = 0.5
	static let iconSize: CGFloat = 24
	static let cornerRadius: CGFloat = 15
	
	enum Paddings {
		static let lineSpacing: CGFloat = 12
		static let horizontalInset: CGFloat = 16
	}
	
	
	
	enum fontSizes {
		static let normal: CGFloat = 32
		static let double: CGFloat = 56
	}
	enum strings {
		static let celcies = "C"
		static let error = "init(coder:) has not been implemented"
		static let imageName = "backGroungWheaterForecast"
		static let errorfetching = "Error fetching weather data:"
	}
}

