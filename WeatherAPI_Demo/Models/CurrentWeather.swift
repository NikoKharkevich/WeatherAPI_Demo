

import Foundation

// модель для обновления интерфейса
struct CurrentWeather {
    let cityName: String
    
    private let temperature: Double
//     для интерфейса формат вывода температуры в Double не нужен, поэтому интерполируем в String
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    private let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        return String(format: "%.1f", feelsLikeTemperature)
    }
    
   private let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    
//     создаем failable init внути которого передаем CurrentWeather
    init?(currentWeatherData: CurrentWeatherData) {
        self.cityName = currentWeatherData.name
        self.temperature = currentWeatherData.main.temp
        self.feelsLikeTemperature = currentWeatherData.main.feelsLike
        self.conditionCode = currentWeatherData.weather.first!.id
    }
}
