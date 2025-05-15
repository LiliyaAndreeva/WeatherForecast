//
//  Sizes.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 13.05.2025.
//

import Foundation
enum Sizes {
	static let alpha: CGFloat = 0.5
	static let iconSize: CGFloat = 40
	static let cornerRadius: CGFloat = 15
	
	
	enum Paddings {
		static let sidePadding: CGFloat = 10
		static let tinyStackSpacing: CGFloat = 4
		static let miniStackSpacing: CGFloat = 8
		static let stackSpacing: CGFloat = 20
		static let topAncorHeight: CGFloat = 24
		static let lineSpacing: CGFloat = 12
		static let horizontalInset: CGFloat = 16
	}

	enum fontSizes {
		static let light: CGFloat = 18
		static let normal: CGFloat = 32
		static let double: CGFloat = 56
	}
	enum itemSizes {
		static let daylyConllectionItem: (CGFloat, CGFloat) = (40, 50)
		static let hourlyConllectionItem: (CGFloat, CGFloat) = (60, 100)
		static let dayLabelWidth: CGFloat = 80
	}
}

