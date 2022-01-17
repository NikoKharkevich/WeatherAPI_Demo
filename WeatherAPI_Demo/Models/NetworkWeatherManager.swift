//
//  NetworkWeatherManager.swift
//  WeatherAPI_Demo
//
//  Created by Nikola Kharkevich on 16.01.2022.
//

import Foundation

struct NetworkWeatherManager {
    func fetchCurrentWeather(forCity city: String) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(K.apiKey)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                self.parseJSON(withData: data)
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) {
        
        let decoder = JSONDecoder()
        
//        декодирования через do catch блок
//        чтобы указать тип в decode ставим .self
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            print(currentWeatherData.main.temp)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
