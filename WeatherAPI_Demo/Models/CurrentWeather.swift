

import Foundation

// модель для обновления интерфейса
struct CurrentWeather {
    let cityName: String
    
    let temperature: Double
//     для интерфейса формат вывода температуры в Double не нужен, поэтому интерполируем в String
    var temperatureString: String {
        return "\(temperature.rounded())"
    }
    
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        return "\(feelsLikeTemperature.rounded())"
    }
    
    let conditionCode: Int
    
//     создаем failable init внути которого передаем CurrentWeather
    init?(currentWeatherData: CurrentWeatherData) {
        self.cityName = currentWeatherData.name
        self.temperature = currentWeatherData.main.temp
        self.feelsLikeTemperature = currentWeatherData.main.feelsLike
        self.conditionCode = currentWeatherData.weather.first!.id
    }
}
