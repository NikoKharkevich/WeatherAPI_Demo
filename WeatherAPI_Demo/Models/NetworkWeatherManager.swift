//
//  NetworkWeatherManager.swift
//  WeatherAPI_Demo
//
//  Created by Nikola Kharkevich on 16.01.2022.
//

import Foundation

// для контроля утечек памяти лучше переделать NetworkWeatherManager со структуры на класс и протокол подписать под class/ AnyObject (значит будет использоваться только классами)
protocol NetworkWeatherManagerDelegate: AnyObject {
    func updateUI(_: NetworkWeatherManager, with currentWeather: CurrentWeather)
}

class NetworkWeatherManager {
    
    weak var delegate: NetworkWeatherManagerDelegate?
        
    func fetchCurrentWeather(forCity city: String) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(K.apiKey)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                    self.delegate?.updateUI(self, with: currentWeather)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> CurrentWeather? {
        
        let decoder = JSONDecoder()
        
        //        декодирования через do catch блок
        //        чтобы указать тип в decode ставим .self
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let  currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
