

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    var networkWeatherManaber = NetworkWeatherManager()
    
    @IBAction func searchPressed(_ sender: UIButton) {
        presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { [unowned self] city in
            self.networkWeatherManaber.fetchCurrentWeather(forCity: city)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.networkWeatherManaber.fetchCurrentWeather(forCity: "London")
        
//        чтобы избежать цикла сильных ссылок используем weal self c извлечением
        networkWeatherManaber.onCompletion = { [weak self] currentWeater in
            guard let self = self else { return }
            self.updateUI(with: currentWeater)
        }
    }
    
    func updateUI(with weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLikeTemperatureLabel.text = weather.feelsLikeTemperatureString
            self.weatherIconImageView.image = UIImage(systemName: weather.systemIconNameString)
        }
    }
}
