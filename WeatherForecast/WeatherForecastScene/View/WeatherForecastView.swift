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
		stack.spacing = Sizes.Paddings.stackSpacing
		stack.alignment = .fill
		stack.backgroundColor = .yellow
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	let backgroundImageView: UIImageView = {
		let backgroundImageView = UIImageView()
		backgroundImageView.contentMode = .scaleAspectFill
		backgroundImageView.clipsToBounds = true
		backgroundImageView.image = UIImage(named: ConstantStrings.imageName)
		backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
		return backgroundImageView
	}()
	
	let cityNameLabel: UILabel = {
		let cityLabel = UILabel()
		cityLabel.textColor = .white
		cityLabel.textAlignment = .center
		cityLabel.backgroundColor = .red
		cityLabel.font = .systemFont(ofSize: Sizes.fontSizes.double, weight: .bold)
		return cityLabel
	}()
	
	let temperatureLabel: UILabel = {
		let tempertureLabel = UILabel()
		tempertureLabel.textColor = .white
		tempertureLabel.textAlignment = .center
		tempertureLabel.backgroundColor = .gray
		tempertureLabel.font = .systemFont(ofSize: Sizes.fontSizes.normal, weight: .bold)
		return tempertureLabel
	}()
	
	let weatherDescribtionLabel: UILabel = {
		let weatherDescribtionLabel = UILabel()
		weatherDescribtionLabel.textColor = .white
		weatherDescribtionLabel.textAlignment = .center
		weatherDescribtionLabel.backgroundColor = .green
		weatherDescribtionLabel.font = .systemFont(ofSize: Sizes.fontSizes.normal, weight: .bold)
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
		layout.minimumLineSpacing = Sizes.Paddings.lineSpacing
		layout.minimumInteritemSpacing = Sizes.Paddings.lineSpacing
		layout.sectionInset = UIEdgeInsets(
			top: 0,
			left: Sizes.Paddings.horizontalInset,
			bottom: 0,
			right: Sizes.Paddings.horizontalInset
		)
		layout.itemSize = CGSize(
			width: Sizes.itemSizes.hourlyConllectionItem.0,
			height: Sizes.itemSizes.hourlyConllectionItem.1
		)
		
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.backgroundColor = #colorLiteral(red: 0.08548969775, green: 0.3861692548, blue: 0.7213394046, alpha: 1).withAlphaComponent(Sizes.alpha)
		collectionView.layer.cornerRadius = Sizes.cornerRadius
		return collectionView
	}()
	
	
	let dailyCollectionView: SelfSizingCollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = Sizes.Paddings.lineSpacing
		layout.itemSize = CGSize(
			width: UIScreen.main.bounds.width - Sizes.itemSizes.daylyConllectionItem.0,
			height: Sizes.itemSizes.daylyConllectionItem.1
		)
		layout.sectionInset = UIEdgeInsets(
			top: Sizes.Paddings.sidePadding,
			left: 0,
			bottom: Sizes.Paddings.sidePadding,
			right: 0
		)
		
		let collectionView = SelfSizingCollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.isScrollEnabled = false
		collectionView.backgroundColor = #colorLiteral(red: 0.08548969775, green: 0.3861692548, blue: 0.7213394046, alpha: 1).withAlphaComponent(Sizes.alpha)
		collectionView.showsVerticalScrollIndicator = false
		collectionView.layer.cornerRadius = Sizes.cornerRadius
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
				
				contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: fifthOfScreen),
				contentStackView.leadingAnchor.constraint(
					equalTo: scrollView.leadingAnchor,
					constant: Sizes.Paddings.horizontalInset
				),
				contentStackView.trailingAnchor.constraint(
					equalTo: scrollView.trailingAnchor,
					constant: -Sizes.Paddings.horizontalInset
				),
				contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
				hourlyCollectionView.heightAnchor.constraint(equalToConstant: thirdOfScreenWidth),

				activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
				activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
			]
		)
	}
}

//TODO: добавить иконку текущего состояния погоды
//TODO: исправить язык? OK
//TODO: сделать отображение 7 дней (бесплатная версия только 3 дня, сделала размер коллекции,
// подстраиваюийся под размер внутреннего контента
//TODO: исправить конфликтующие констрейнты
//TODO: почистить лишние свойства у модели
//TODO: почистить хардкод


