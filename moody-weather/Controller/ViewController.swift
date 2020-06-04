//
//  ViewController.swift
//  moody-weather
//
//  Created by Bo on 6/2/20.
//  Copyright © 2020 Jessica Trinh. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var happyButton: UIButton!
    @IBOutlet weak var neutralButton: UIButton!
    @IBOutlet weak var sadButton: UIButton!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
    }
    @IBAction func happyPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Yay!", message: "It's a great day to be happy!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Thank you!", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func neutralPressed(_ sender: Any) {
        let alert = UIAlertController(title: "It's Okay!", message: "There's always tomorrow!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Looking forward!", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func sadPressed(_ sender: Any) {
        let alert = UIAlertController(title: "): there there", message: "It's okay to have off days", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Thanks", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    

}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension ViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = "Today's weath in \(weather.cityName) is"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


