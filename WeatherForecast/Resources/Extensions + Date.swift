//
//  Extensions + Date.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 14.05.2025.
//

import Foundation
extension Date {
	func dayOfWeek(format: String = "EEEE", localeIdentifier: String = "ru_RU") -> String {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: localeIdentifier)
		formatter.dateFormat = format 
		return formatter.string(from: self)
	}
	
	func formattedDayOfWeek(referenceDate: Date = Date()) -> String {
		let calendar = Calendar.current
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "ru_RU")
		formatter.dateFormat = "EE" 

		if calendar.isDate(self, inSameDayAs: referenceDate) {
			return ConstantStrings.today
		} else {
			let capitalized = formatter.string(from: self).capitalized
			return capitalized
		}
	}
}
