//
//  CityDataSource.swift
//  PharmacyInfo
//
//  Created by apple on 22.11.2022.
//

import Foundation

class CityDataSource{ //struct değil class olması gerekiyor mutable olması için
    
    private var CityList :[City] = []
    private let baseURL = "https://api.weatherapi.com/v1/search.json?key=49a0562ede0447a280b91717222912&q="
    var delegate: CityDataDelegate?
    init(){
    }
    
    func getNumberOfCities() -> Int {
        return CityList.count
    }
    
    func getListOfCities(search:String) {
        print("A")
        let session = URLSession.shared
        if let url = URL(string: "\(baseURL)\(search)"){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let dataTask = session.dataTask(with: request){
                data,response,error in
                //print(data) //step 1
                
                if let data = data { //step2
                    if String(data:data,encoding: .utf8)?.first != "{" {
                        //print(String(data:data,encoding: .utf8))
                        let decoder =    JSONDecoder()
                        
                        self.CityList = try! decoder.decode([City].self, from:data) //step3
                        //print(self.CityList) // step4
                        DispatchQueue.main.async {
                            self.delegate?.CityDataLoaded()
                        }
                    }
                    
                    
                    
                }
                //print("B")
            }
            //print("C")
            dataTask.resume()
            
        }
        
    }
    func getCity(for id:Int) -> City? {
            guard id < CityList.count else {
                return nil
            }
            return CityList[id]
        
    }
    
    }

