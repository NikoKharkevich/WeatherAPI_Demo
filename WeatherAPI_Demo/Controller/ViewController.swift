

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    var networkWeatherManaber = NetworkWeatherManager()
    
    @IBAction func searchPressed(_ sender: UIButton) {
        presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { city in
            self.networkWeatherManaber.fetchCurrentWeather(forCity: city)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.networkWeatherManaber.delegate = self
        self.networkWeatherManaber.fetchCurrentWeather(forCity: "London") 
    }
}

extension ViewController: NetworkWeatherManagerDelegate {
    func updateUI(_: NetworkWeatherManager, with currentWeather: CurrentWeather) {
        print(currentWeather.temperature)
    }
    
}
