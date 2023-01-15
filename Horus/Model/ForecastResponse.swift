//
//  Forecast.swift
//  Horus
//
//  Created by Kerem Girenes on 15.01.2023.
//

import Foundation

struct ForecastResponse: Decodable {
    let forecast: ForecastDetail
}

struct ForecastDetail: Decodable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Decodable {
    let date: String
    let hour: [Forecast]
}

struct Forecast: Decodable {
    let time: String
    let temp_c: Float
    let condition: Condition
    let wind_kph: Float
    let humidity: Int
}
