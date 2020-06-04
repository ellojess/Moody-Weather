//
//  WeatherData.swift
//  moody-weather
//
//  Created by Bo on 6/4/20.
//  Copyright © 2020 Jessica Trinh. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
}

struct Main: Codable {
    let temp: Double
}
