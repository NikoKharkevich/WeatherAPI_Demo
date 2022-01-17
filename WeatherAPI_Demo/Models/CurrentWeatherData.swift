
import Foundation

// модель для получения данных из JSON
struct CurrentWeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    
//    данные приходят по этоу ключу "feels_like" и если мы хотим его переписать со снейк кейс на кеммел кейс то нужно испольховать enum c CodingKey
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

struct Weather: Codable {
    let id: Int
}
