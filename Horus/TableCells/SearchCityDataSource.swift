//
//  CityDataSource.swift
//  PharmacyInfo
//
//  Created by apple on 22.11.2022.
//

import Foundation

class SearchCityDataSource {
    
    var cityList: [City] = []
    
    private let baseURL = "https://api.weatherapi.com/v1/search.json?key=49a0562ede0447a280b91717222912&q="
    
    var delegate: CityDataDelegate?
    
    init(){
        
    }
    
    func getNumberOfCities() -> Int {
        return cityList.count
    }
    
    func getListOfCities(search:String) {
        print("Search Call Sent for \(search)")
        let session = URLSession.shared
        if let url = URL(string: "\(baseURL)\(search)"){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let dataTask = session.dataTask(with: request){
                data,response,error in
                if let data = data {
                    if String(data:data,encoding: .utf8)?.first != "{" {
                        let decoder = JSONDecoder()
                        self.cityList = try! decoder.decode([City].self, from:data)
                        DispatchQueue.main.async {
                            self.delegate?.cityListLoaded()
                            print("Search Data Got for \(search)")
                        }
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func getCity(for id:Int) -> City? {
        guard id < cityList.count else {
            return nil
        }
        return cityList[id]
    }
    
}

