//
//  HourlyWeatherCell.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 14.05.2025.
//

import UIKit
final class HourlyWeatherCell: UICollectionViewCell {
	static let reuseIdentifier = ConstantStrings.hourlyWeatherCellReuseIdentifier

	private let timeLabel = UILabel()
	private let tempLabel = UILabel()
	let iconImageView = UIImageView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setup() {
		timeLabel.font = .systemFont(ofSize: Sizes.fontSizes.light)
		timeLabel.textColor = .white
		timeLabel.textAlignment = .center
		timeLabel.translatesAutoresizingMaskIntoConstraints = false

		iconImageView.contentMode = .scaleAspectFit
		iconImageView.tintColor = .white
		iconImageView.translatesAutoresizingMaskIntoConstraints = false

		tempLabel.font = .systemFont(ofSize: Sizes.fontSizes.light)
		tempLabel.textColor = .white
		tempLabel.textAlignment = .center
		tempLabel.translatesAutoresizingMaskIntoConstraints = false

		let stack = UIStackView(arrangedSubviews: [timeLabel, iconImageView, tempLabel])
		stack.axis = .vertical
		stack.alignment = .fill
		stack.spacing = Sizes.Paddings.tinyStackSpacing
		stack.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(stack)

		NSLayoutConstraint.activate([
			stack.topAnchor.constraint(equalTo: contentView.topAnchor),
			stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			// ❗️Добавляем ограничение высоты для иконки
			iconImageView.heightAnchor.constraint(equalToConstant: 30),
			
			// (опционально) ограничения по высоте для лейблов:
			timeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15),
			tempLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15)
		])
	}

	func configure(with model: WeatherForecastDisplayModel.HourlyForecast) {
		timeLabel.text = model.time
		tempLabel.text = model.temperature
	}
}
