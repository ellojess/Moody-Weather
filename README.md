# Moody-Weather

Moody Weather is a weather app that tracks users moods!

## Previews

### Home Screen

<img src="img/Screen Shot 2020-06-04 at 4.00.42 PM.png" width="250">  

### Options
Input moods 

<img src="img/Screen Shot 2020-06-04 at 4.01.30 PM.png" width="250">  <img src="img/Screen Shot 2020-06-04 at 4.02.00 PM.png" width="250">  <img src="img/Screen Shot 2020-06-04 at 4.02.11 PM.png" width="250">  



## Getting Started

Note: Newsstand is still in the process of developmemt.

In order to preview this app, you will need to clone this repository and open it in Xcode
 - If you do not have Xcode you can download it [here](https://developer.apple.com/xcode/)
 
### Example of Coding Style 
Making a request to News API to fetch articles based on the category a user chooses
```swift
import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct  WeatherManager {
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?&appid=\(apikey)&unites=imperial"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(cityName: name, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
```

## Built With

* [Swift](https://swift.org/documentation/) - Language 
* [Xcode](https://developer.apple.com/xcode/) - IDE
* [Open Weather API](https://openweathermap.org/api) - API
