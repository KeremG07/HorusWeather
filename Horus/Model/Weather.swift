//
//  Weather.swift
//  Horus
//
//  Created by apple on 6.01.2023.
//

import Foundation

struct Weather: Decodable {
    let current: WeatherDegreeAndCondition
    let location: Location
}

struct WeatherDegreeAndCondition: Decodable{
    let temp_c: Float
    let condition: Condition
}

struct Condition: Decodable{
    let text: String
}

struct Location: Decodable {
    let name:String
    let lat:Float
    let lon:Float
}
