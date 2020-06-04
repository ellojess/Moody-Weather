//
//  WeatherManager.swift
//  moody-weather
//
//  Created by Bo on 6/4/20.
//  Copyright © 2020 Jessica Trinh. All rights reserved.
//

import Foundation

struct  WeatherManager {
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?&appid=\(apikey)&unites=imperial"
    
    func fetchWeather(cityName: String) {
        let url = "\(weatherURL)&q=\(cityName)"
    }
}
