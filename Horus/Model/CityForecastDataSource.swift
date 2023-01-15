//
//  CityForecastDataSource.swift
//  Horus
//
//  Created by Kerem Girenes on 15.01.2023.
//

import Foundation

class CityForecastDataSource: ObservableObject {
    
    private var forecastList: [Forecast] = []
    
    private let baseURL = "http://api.weatherapi.com/v1/forecast.json?key=49a0562ede0447a280b91717222912&q="
    private let baseURLC = "&days=1&aqi=no&alerts=no"
    
    var delegate: ForecastDataDelegate?
    
    init() {}
    
    func getForecastList() -> [Forecast] {
        return forecastList
    }
    
    func getForecast(for index: Int) -> Forecast? {
        guard index < forecastList.count else {
            return nil
        }
        return forecastList[index]
    }
    
    func getForecastsIntoList(cityName: String) {
        forecastList.removeAll(keepingCapacity: false)
        let session = URLSession.shared
        if let url = URL(string: "\(baseURL)\(cityName)\(baseURLC)") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let dataTask = session.dataTask(with: request) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let forecast = try decoder.decode(ForecastResponse.self, from: data)
                        let hours = forecast.forecast.forecastday[0].hour
                        for hour in hours {
                            let hourForecast = Forecast(time: hour.time, temp_c: hour.temp_c, condition: hour.condition, wind_kph: hour.wind_kph, humidity: hour.humidity)
                            self.forecastList.append(hourForecast)
                        }
                    } catch {
                        print("Error decoding forecast data: \(error)")
                    }
                }
            }
            dataTask.resume()
        }
    }
}
