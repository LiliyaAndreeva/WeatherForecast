//
//  WeatherForecastCell.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 14.05.2025.
//

import UIKit

class WeatherForecastCell: UICollectionViewCell {
	static let reuseIdentifier = ConstantStrings.weatherForecastCellReuseIdentifier
	
	private let dayLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: Sizes.fontSizes.light, weight: .medium)
		label.textColor = .white
		label.textAlignment = .left
		return label
	}()
	
	let weatherIconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private let minTemperatureLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: Sizes.fontSizes.light, weight: .regular)
		label.textColor = .white
		label.textAlignment = .center
		return label
	}()
	
	private let progressView: UIProgressView = {
		let progressView = UIProgressView(progressViewStyle: .default)
		progressView.progressTintColor = .yellow
		progressView.trackTintColor = .gray
		return progressView
	}()
	
	private let maxTemperatureLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: Sizes.fontSizes.light, weight: .bold)
		label.textColor = .white
		label.textAlignment = .center
		return label
	}()
	
	private let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = Sizes.Paddings.miniStackSpacing
		stackView.alignment = .center
		stackView.distribution = .fill
		return stackView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupUI() {
		contentView.addSubview(stackView)

		stackView.addArrangedSubview(dayLabel)
		stackView.addArrangedSubview(weatherIconImageView)
		stackView.addArrangedSubview(minTemperatureLabel)
		stackView.addArrangedSubview(progressView)
		stackView.addArrangedSubview(maxTemperatureLabel)
		
		dayLabel.setContentHuggingPriority(.required, for: .horizontal)
		dayLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			dayLabel.widthAnchor.constraint(equalToConstant: Sizes.itemSizes.dayLabelWidth)
		])
		
		weatherIconImageView.heightAnchor.constraint(equalToConstant: Sizes.iconSize).isActive = true
		weatherIconImageView.widthAnchor.constraint(equalToConstant: Sizes.iconSize).isActive = true
	}
	
	func configure(with model: WeatherForecastDisplayModel.DailyForecast) {
		dayLabel.text = "\(model.date)"
		minTemperatureLabel.text = "\(model.minTemp)°"
		maxTemperatureLabel.text = "\(model.maxTemp)°"
		
		if let minTemp = Float(model.minTemp), let maxTemp = Float(model.maxTemp) {
			let progress = (maxTemp - minTemp) / 50.0 
			progressView.setProgress(min(max(progress, 0), 1), animated: true)
		} else {
			progressView.setProgress(0, animated: false)
		}
	}
}
