//
//  WeatherForecastView.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 13.05.2025.
//

import UIKit

final class WeatherForecastView: UIView {
	
	let backgroundImageView: UIImageView = {
		let backgroundImageView = UIImageView()
		//backgroundImageView.frame = view.bounds
		backgroundImageView.contentMode = .scaleAspectFill
		backgroundImageView.clipsToBounds = true
		backgroundImageView.image = UIImage(named: SizesAndStrings.strings.imageName)
		return backgroundImageView
	}()

	let cityNameLabel: UILabel = {
		let cityLabel = UILabel()
		cityLabel.textColor = .white
		cityLabel.font = .systemFont(ofSize: SizesAndStrings.fontSizes.double, weight: .bold)
		return cityLabel
	}()

	let temperatureLabel: UILabel = {
		let tempertureLabel = UILabel()
		tempertureLabel.textColor = .white
		tempertureLabel.font = .systemFont(ofSize: SizesAndStrings.fontSizes.normal, weight: .bold)
		return tempertureLabel
	}()

	let weatherDescribtionLabel: UILabel = {
		let weatherDescribtionLabel = UILabel()
		weatherDescribtionLabel.textColor = .white
		weatherDescribtionLabel.font = .systemFont(ofSize: SizesAndStrings.fontSizes.normal, weight: .bold)
		return weatherDescribtionLabel
	}()

	let activityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.color = .white
		indicator.hidesWhenStopped = true
		return indicator
	} ()
	
	let hourlyCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 12
		layout.minimumInteritemSpacing = 12
		layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
		layout.itemSize = CGSize(width: 60, height: 100)

		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.backgroundColor = .clear
		return collectionView
	}()
	
	override init(frame: CGRect) {
			super.init(frame: frame)
			setupView()
			setupLayout()
		}

		required init?(coder: NSCoder) {
			super.init(coder: coder)
			setupView()
			setupLayout()
		}
}

private extension WeatherForecastView {
	func setupView() {
		addSubview(backgroundImageView)
		addSubview(cityNameLabel)
		addSubview(temperatureLabel)
		addSubview(weatherDescribtionLabel)
		addSubview(activityIndicator)
		addSubview(hourlyCollectionView)

		backgroundImageView.frame = bounds
	}

	private func setupLayout() {
		[
			backgroundImageView,
			cityNameLabel,
			temperatureLabel,
			weatherDescribtionLabel,
			activityIndicator,
			hourlyCollectionView
		].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
		let screenWidth = UIScreen.main.bounds.width
		let thirdOfScreenWidth = screenWidth / 3
		let distance = screenWidth * 0.2

		NSLayoutConstraint.activate([
			
			backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
			backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
			
			cityNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: thirdOfScreenWidth),
			cityNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			
			temperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: distance),
			temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			
			weatherDescribtionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: distance),
			weatherDescribtionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			
			hourlyCollectionView.topAnchor.constraint(equalTo: weatherDescribtionLabel.bottomAnchor, constant: 24),
			hourlyCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			hourlyCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			hourlyCollectionView.heightAnchor.constraint(equalToConstant: 100),
			
			activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
	}
}
