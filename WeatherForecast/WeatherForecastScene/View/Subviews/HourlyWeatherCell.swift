//
//  HourlyWeatherCell.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 14.05.2025.
//

import UIKit
final class HourlyWeatherCell: UICollectionViewCell {
	static let reuseIdentifier = "HourlyWeatherCell"

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
		timeLabel.font = .systemFont(ofSize: 14)
		timeLabel.textColor = .white
		timeLabel.textAlignment = .center

		iconImageView.contentMode = .scaleAspectFit
		iconImageView.tintColor = .white

		tempLabel.font = .systemFont(ofSize: 14)
		tempLabel.textColor = .white
		tempLabel.textAlignment = .center

		let stack = UIStackView(arrangedSubviews: [timeLabel, iconImageView, tempLabel])
		stack.axis = .vertical
		stack.alignment = .center
		stack.spacing = 4
		stack.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(stack)

		NSLayoutConstraint.activate([
			stack.topAnchor.constraint(equalTo: contentView.topAnchor),
			stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		])
	}

	func configure(time: String, temp: String/*, icon: UIImage?*/) {
		timeLabel.text = time
		tempLabel.text = temp
		//iconImageView.image = icon
	}
}
