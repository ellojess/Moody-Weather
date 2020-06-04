//
//  WeatherModel.swift
//  moody-weather
//
//  Created by Bo on 6/4/20.
//  Copyright © 2020 Jessica Trinh. All rights reserved.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let temperature: Double

    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
}
