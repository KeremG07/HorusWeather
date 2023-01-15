//
//  CityDataSource.swift
//  Horus
//
//  Created by Kerem Girenes on 15.01.2023.
//

import Foundation

class CityCurrentWeatherDataSource {
    
    private let baseURL = "http://api.weatherapi.com/v1/current.json?key=49a0562ede0447a280b91717222912&q="
    private let baseURLC = "&aqi=no"
    
    var delegate: WeatherDataDelegate?
    
    init() {
        
    }
    
    func getWeatherDataOfCity(cityName: String, completion: @escaping (Weather?) -> Void) -> Weather? {
        var weatherData: Weather?
        let session = URLSession.shared
        if let url = URL(string: "\(baseURL)\(cityName)\(baseURLC)"){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let dataTask = session.dataTask(with: request) { data, response, error in
                print(data ?? "unknown weather response")
                if let data = data {
                    let decoder = JSONDecoder()
                    let weather = try! decoder.decode(Weather.self, from: data)
                    weatherData = weather
                    DispatchQueue.main.async {
                        completion(weather)
                        self.delegate?.WeatherDataLoaded()
                        print("Weather Data Got for \(cityName)")
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
            dataTask.resume()
        }
        return weatherData
    }
}
