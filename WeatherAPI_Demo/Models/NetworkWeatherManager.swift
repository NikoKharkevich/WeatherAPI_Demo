//
//  NetworkWeatherManager.swift
//  WeatherAPI_Demo
//
//  Created by Nikola Kharkevich on 16.01.2022.
//

import Foundation

class NetworkWeatherManager {
    
    var onCompletion: ((CurrentWeather) -> Void)?
        
    func fetchCurrentWeather(forCity city: String) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&apikey=\(K.apiKey)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                    self.onCompletion?(currentWeather)
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
