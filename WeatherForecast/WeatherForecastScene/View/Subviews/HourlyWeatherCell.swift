//
//  HourlyWeatherCell.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 14.05.2025.
//

import UIKit
final class HourlyWeatherCell: UICollectionViewCell {
	static let reuseIdentifier = ConstantStrings.hourlyWeatherCellReuseIdentifier
	
	private let timeLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: Sizes.fontSizes.light)
		label.textColor = .white
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let tempLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: Sizes.fontSizes.light)
		label.textColor = .white
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private let stackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.alignment = .center
		stack.distribution = .fill
		stack.spacing = Sizes.Paddings.tinyStackSpacing
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()

	let iconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.tintColor = .white
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setup() {
		contentView.addSubview(stackView)
		stackView.addArrangedSubview(timeLabel)
		stackView.addArrangedSubview(iconImageView)
		stackView.addArrangedSubview(tempLabel)
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			
			timeLabel.heightAnchor.constraint(equalToConstant: 16),
			tempLabel.heightAnchor.constraint(equalToConstant: 16)
		])
	}
	
	func configure(with model: WeatherForecastDisplayModel.HourlyForecast) {
		timeLabel.text = model.time
		tempLabel.text = model.temperature
	}
}
