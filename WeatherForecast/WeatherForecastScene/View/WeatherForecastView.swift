//
//  WeatherForecastView.swift
//  WeatherForecast
//
//  Created by Лилия Андреева on 13.05.2025.
//

import UIKit

final class WeatherForecastView: UIView {
	
	private let scrollView = UIScrollView()
	private let contentStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.spacing = 20
		stack.alignment = .fill
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	let backgroundImageView: UIImageView = {
		let backgroundImageView = UIImageView()
		backgroundImageView.contentMode = .scaleAspectFill
		backgroundImageView.clipsToBounds = true
		backgroundImageView.image = UIImage(named: SizesAndStrings.strings.imageName)
		backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
		return backgroundImageView
	}()
	
	let cityNameLabel: UILabel = {
		let cityLabel = UILabel()
		cityLabel.textColor = .white
		cityLabel.textAlignment = .center
		cityLabel.font = .systemFont(ofSize: SizesAndStrings.fontSizes.double, weight: .bold)
		return cityLabel
	}()
	
	let temperatureLabel: UILabel = {
		let tempertureLabel = UILabel()
		tempertureLabel.textColor = .white
		tempertureLabel.textAlignment = .center
		tempertureLabel.font = .systemFont(ofSize: SizesAndStrings.fontSizes.normal, weight: .bold)
		return tempertureLabel
	}()
	
	let weatherDescribtionLabel: UILabel = {
		let weatherDescribtionLabel = UILabel()
		weatherDescribtionLabel.textColor = .white
		weatherDescribtionLabel.textAlignment = .center
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
		layout.minimumLineSpacing = SizesAndStrings.Paddings.lineSpacing
		layout.minimumInteritemSpacing = SizesAndStrings.Paddings.lineSpacing
		layout.sectionInset = UIEdgeInsets(
			top: 0,
			left: SizesAndStrings.Paddings.horizontalInset,
			bottom: 0,
			right: SizesAndStrings.Paddings.horizontalInset
		)
		layout.itemSize = CGSize(width: 60, height: 100)
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.backgroundColor = #colorLiteral(red: 0.08548969775, green: 0.3861692548, blue: 0.7213394046, alpha: 1).withAlphaComponent(SizesAndStrings.alpha)
		collectionView.layer.cornerRadius = SizesAndStrings.cornerRadius
		return collectionView
	}()
	
	
	let dailyCollectionView: SelfSizingCollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = SizesAndStrings.Paddings.lineSpacing
		layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 50)
		layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
		
		let collectionView = SelfSizingCollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.isScrollEnabled = false
		collectionView.backgroundColor = #colorLiteral(red: 0.08548969775, green: 0.3861692548, blue: 0.7213394046, alpha: 1).withAlphaComponent(SizesAndStrings.alpha)
		collectionView.showsVerticalScrollIndicator = false
		collectionView.layer.cornerRadius = SizesAndStrings.cornerRadius
		return collectionView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViewScroll()
		setupLayout()
		hourlyCollectionView.isHidden = true
		dailyCollectionView.isHidden = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension WeatherForecastView {
	func setupViewScroll() {
		addSubview(backgroundImageView)
		addSubview(scrollView)
		scrollView.addSubview(contentStackView)
		
		[
			cityNameLabel,
			temperatureLabel,
			weatherDescribtionLabel,
			hourlyCollectionView,
			dailyCollectionView,
			activityIndicator
		].forEach { contentStackView.addArrangedSubview($0) }
		
		[cityNameLabel, temperatureLabel, weatherDescribtionLabel, activityIndicator].forEach {
			$0.setContentHuggingPriority(.required, for: .vertical)
			$0.setContentCompressionResistancePriority(.required, for: .vertical)
		}
	}
	
	
	private func setupLayout() {
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		
		let screenWidth = UIScreen.main.bounds.width
		let thirdOfScreenWidth = screenWidth / 3
		let fifthOfScreen = screenWidth / 5
		let distance = screenWidth * 0.2
		
		NSLayoutConstraint.activate(
			[
				
				backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
				backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
				backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
				backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
				
				
				scrollView.topAnchor.constraint(equalTo: topAnchor),
				scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
				scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
				scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
				
				contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
				contentStackView.leadingAnchor.constraint(
					equalTo: scrollView.leadingAnchor
				),
				contentStackView.trailingAnchor.constraint(
					equalTo: scrollView.trailingAnchor
				),
				contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
				contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
				
				cityNameLabel.topAnchor.constraint(equalTo: contentStackView.topAnchor, constant: fifthOfScreen),
				cityNameLabel.centerXAnchor.constraint(equalTo: contentStackView.centerXAnchor),
				
				temperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: distance),
				temperatureLabel.centerXAnchor.constraint(equalTo: contentStackView.centerXAnchor),
				
				weatherDescribtionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: distance),
				weatherDescribtionLabel.centerXAnchor.constraint(equalTo: contentStackView.centerXAnchor),
				
				hourlyCollectionView.topAnchor.constraint(
					equalTo: weatherDescribtionLabel.bottomAnchor,
					constant: SizesAndStrings.iconSize
				),
				hourlyCollectionView.leadingAnchor.constraint(
					equalTo: contentStackView.leadingAnchor,
					constant: SizesAndStrings.Paddings.horizontalInset
				),
				hourlyCollectionView.trailingAnchor.constraint(
					equalTo: contentStackView.trailingAnchor,
					constant: -SizesAndStrings.Paddings.horizontalInset
				),
				hourlyCollectionView.heightAnchor.constraint(equalToConstant: thirdOfScreenWidth),
				
				dailyCollectionView.topAnchor.constraint(
					equalTo: hourlyCollectionView.bottomAnchor,
					constant: SizesAndStrings.Paddings.lineSpacing
				),
				dailyCollectionView.leadingAnchor.constraint(
					equalTo: contentStackView.leadingAnchor,
					constant: SizesAndStrings.Paddings.horizontalInset
				),
				dailyCollectionView.trailingAnchor.constraint(
					equalTo: contentStackView.trailingAnchor,
					constant: -SizesAndStrings.Paddings.horizontalInset
				),

				activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
				activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
			]
		)
	}
}

//TODO: добавить иконку текущего состояния погоды
//TODO: исправить язык? OK
//TODO: сделать отображение 7 дней
//TODO: исправить конфликтующие констрейнты
//TODO: почистить лишние свойства у модели
//TODO: почистить хардкод


