//
//  ForecastWeather.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 13.05.2025.
//

import Foundation

// MARK: - ForecastWeatherResponse
struct ForecastWeatherResponse: Codable {
	let location: Location
	let current: CurrentWeather
	let forecast: Forecast
}

// MARK: - Forecast
struct Forecast: Codable {
	let forecastday: [ForecastDay]
}

// MARK: - ForecastDay
struct ForecastDay: Codable {
	let date: String
	let dateEpoch: Int
	let day: Day
	let astro: Astro
	let hour: [HourlyForecast]

	enum CodingKeys: String, CodingKey {
		case date
		case dateEpoch = "date_epoch"
		case day
		case astro
		case hour
	}
}

// MARK: - Day (daily summary)
struct Day: Codable {
	let maxtempC: Double
	let maxtempF: Double
	let mintempC: Double
	let mintempF: Double
	let avgtempC: Double
	let avgtempF: Double
	let maxwindMph: Double
	let maxwindKph: Double
	let totalprecipMm: Double
	let totalprecipIn: Double
	let avgvisKm: Double
	let avgvisMiles: Double
	let avghumidity: Double
	let dailyWillItRain: Int
	let dailyChanceOfRain: String
	let dailyWillItSnow: Int
	let dailyChanceOfSnow: String
	let condition: Condition
	let uv: Double

	enum CodingKeys: String, CodingKey {
		case maxtempC = "maxtemp_c"
		case maxtempF = "maxtemp_f"
		case mintempC = "mintemp_c"
		case mintempF = "mintemp_f"
		case avgtempC = "avgtemp_c"
		case avgtempF = "avgtemp_f"
		case maxwindMph = "maxwind_mph"
		case maxwindKph = "maxwind_kph"
		case totalprecipMm = "totalprecip_mm"
		case totalprecipIn = "totalprecip_in"
		case avgvisKm = "avgvis_km"
		case avgvisMiles = "avgvis_miles"
		case avghumidity
		case dailyWillItRain = "daily_will_it_rain"
		case dailyChanceOfRain = "daily_chance_of_rain"
		case dailyWillItSnow = "daily_will_it_snow"
		case dailyChanceOfSnow = "daily_chance_of_snow"
		case condition
		case uv
	}
}

// MARK: - Astro (sunrise/sunset)
struct Astro: Codable {
	let sunrise: String
	let sunset: String
	let moonrise: String
	let moonset: String
	let moonPhase: String
	let moonIllumination: String

	enum CodingKeys: String, CodingKey {
		case sunrise, sunset, moonrise, moonset
		case moonPhase = "moon_phase"
		case moonIllumination = "moon_illumination"
	}
}

// MARK: - HourlyForecast
struct HourlyForecast: Codable {
	let timeEpoch: Int
	let time: String
	let tempC: Double
	let tempF: Double
	let isDay: Int
	let condition: Condition
	let windMph: Double
	let windKph: Double
	let windDegree: Int
	let windDir: String
	let pressureMb: Double
	let pressureIn: Double
	let precipMm: Double
	let precipIn: Double
	let humidity: Int
	let cloud: Int
	let feelslikeC: Double
	let feelslikeF: Double
	let windchillC: Double
	let windchillF: Double
	let heatindexC: Double
	let heatindexF: Double
	let dewpointC: Double
	let dewpointF: Double
	let willItRain: Int
	let chanceOfRain: String
	let willItSnow: Int
	let chanceOfSnow: String
	let visKm: Double
	let visMiles: Double
	let gustMph: Double
	let gustKph: Double
	let uv: Double

	enum CodingKeys: String, CodingKey {
		case timeEpoch = "time_epoch"
		case time
		case tempC = "temp_c"
		case tempF = "temp_f"
		case isDay = "is_day"
		case condition
		case windMph = "wind_mph"
		case windKph = "wind_kph"
		case windDegree = "wind_degree"
		case windDir = "wind_dir"
		case pressureMb = "pressure_mb"
		case pressureIn = "pressure_in"
		case precipMm = "precip_mm"
		case precipIn = "precip_in"
		case humidity, cloud
		case feelslikeC = "feelslike_c"
		case feelslikeF = "feelslike_f"
		case windchillC = "windchill_c"
		case windchillF = "windchill_f"
		case heatindexC = "heatindex_c"
		case heatindexF = "heatindex_f"
		case dewpointC = "dewpoint_c"
		case dewpointF = "dewpoint_f"
		case willItRain = "will_it_rain"
		case chanceOfRain = "chance_of_rain"
		case willItSnow = "will_it_snow"
		case chanceOfSnow = "chance_of_snow"
		case visKm = "vis_km"
		case visMiles = "vis_miles"
		case gustMph = "gust_mph"
		case gustKph = "gust_kph"
		case uv
	}
}
