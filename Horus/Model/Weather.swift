//
//  Weather.swift
//  Horus
//
//  Created by apple on 6.01.2023.
//

import Foundation
/* "location": {
        "name": "Sariyer",
        "region": "Mugla",
        "country": "Turkey",
        "lat": 36.67,
        "lon": 29.42,
        "tz_id": "Europe/Istanbul",
        "localtime_epoch": 1672997260,
        "localtime": "2023-01-06 12:27"
    },
    "current": {
        "last_updated_epoch": 1672996500,
        "last_updated": "2023-01-06 12:15",
        "temp_c": 14.0,
        "temp_f": 57.2,
        "is_day": 1,
        "condition": {
            "text": "Sunny",
            "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
            "code": 1000
        },
*/
struct Weather: Decodable { //decodeable yap
    //let location : Int
    let current: WeatherDegreeAndCondition
    let location: Location
}



struct WeatherDegreeAndCondition:Decodable{
    let temp_c:Float
    let condition: Condition
}

struct Condition:Decodable{
    let text:String
}


struct Location: Decodable {
    let name:String
    let lat:Float
    let lon:Float
}
