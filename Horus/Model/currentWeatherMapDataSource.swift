//
//  currentWeatherMapDataSource.swift
//  Horus
//
//  Created by apple on 6.01.2023.
//

import Foundation

//http://api.weatherapi.com/v1/current.json?key=49a0562ede0447a280b91717222912&q=bursa&aqi=no

class currentWeatherMapDataSource { //struct değil class olması gerekiyor mutable olması için
    
    var weatherList :[Weather] = []
    //var currentWeatherDegreeAndCondition: WeatherDegreeAndCondition
    private let baseURL = "http://api.weatherapi.com/v1/current.json?key=49a0562ede0447a280b91717222912&q="
    private let baseURLC = "&aqi=no"
    var delegate: WeatherDataDelegate?
    init(){
        
    }
    
    /*
    func getNumberOfCities() -> Int {
        return CityList.count
    }
     */
    
    
    
    func getWeather(search:String) {
        print("Weather Call Sent for \(search)")
        let session = URLSession.shared
        if let url = URL(string: "\(baseURL)\(search)\(baseURLC)"){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let dataTask = session.dataTask(with: request){
                data,response,error in
                print(data)
                
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    var weather = try! decoder.decode(Weather.self, from:data)
                
                    self.weatherList.append(weather)
                    DispatchQueue.main.async {
                        self.delegate?.WeatherDataLoaded()
                    
                        print("Weather Data Got for \(search)")
                    }
                }
            }
            dataTask.resume()
            
        }
        
    }
    
    func getWeatherDegreeAndCondition(search: String) {
        let session = URLSession.shared
        if let url = URL(string: "\(baseURL)\(search)\(baseURLC)"){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let dataTask = session.dataTask(with: request){ data,response,error in
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    //self.currentWeatherDegreeAndCondition = try! decoder.decode(WeatherDegreeAndCondition.self, from:data)
                    
                    DispatchQueue.main.async {
                        self.delegate?.WeatherDataLoaded()
                    }
                }
            }
            dataTask.resume()
        }
    }
}
