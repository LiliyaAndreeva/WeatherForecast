# 🌤️ WeatherForecast iOS App

WeatherForecast — это iOS-приложение для отображения текущей и прогнозной погоды. Приложение использует [WeatherAPI](https://www.weatherapi.com/) и определяет местоположение пользователя для показа актуальной информации.

## 📱 Скриншот
![Максимальный вариант](https://github.com/LiliyaAndreeva/WeatherForecast/blob/main/Screens.png)

---

## 🚀 Возможности

- Получение текущей погоды по геолокации
- Почасовой прогноз на текущие сутки
- Прогноз на 7 дней вперёд 
- Отображение иконок погоды
- Обработка отказа в доступе к геолокации (по умолчанию — Москва)
- Обработка ошибок и повторная загрузка данных

---

## 🧱 Архитектура

Проект построен с использованием MVVM:
	•	Model — структуры данных, полученные из API
	•	ViewModel — бизнес-логика и подготовка данных для отображения
	•	View (ViewController) — UI-компоненты без использования Storyboard
	•	Services — работа с сетью и геолокацией (WeatherService, LocationService, NetworkService)

Используемый фреймворк: UIKit
Асинхронность реализована через GCD. Изображения погоды загружаются и кэшируются с помощью Kingfisher.

## 🛠️ Установка

1. Склонируй репозиторий:

```bash
git clone https://github.com/yourusername/WeatherForecast.git
cd WeatherForecast
