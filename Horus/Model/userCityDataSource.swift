//
//  userCityDataSource.swift
//  Horus
//
//  Created by apple on 5.01.2023.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class UserCityDataSource: ObservableObject {
    
    private var cityList : [City] = []
    
    private let ref = Database.database(url: "https://horus-weather-app-8eb89-default-rtdb.europe-west1.firebasedatabase.app/").reference()
    
    var delegate: CityDataDelegate?
    
    func getCityList() -> [City] {
        print(cityList)
        return cityList
    }
    
    func getCity(for index: Int) -> City? {
        guard index < cityList.count else {
            return nil
        }
        return cityList[index]
    }
    
    func getCenter() -> [Int]{
        var minLat = 200
        var maxLat  = -200
        var minLon = 200
        var maxLon = -200
        
        for city in self.cityList {
            let curLon = Int(city.lon)
            let curLat = Int(city.lat)
            
            if curLon <= minLon{
                minLon=curLon
            }
            if curLon >= maxLon{
                maxLon = curLon
            }
            if curLat <= minLat{
                minLat=curLat
            }
            if curLat >= maxLat{
                maxLat = curLat
            }
                    
        }
        
        return [(maxLat-minLat),(maxLon-minLon),Int((maxLat+minLat)/2),Int((maxLon+minLon)/2)]
        
    }
    
    func pushCityWithCityID(username: String, city: City) {
        let cityID = city.id
        self.ref.child(username).child(String(cityID)).setValue(city.toDictionary)
        DispatchQueue.main.async {
            self.readCitiesIntoCityList(username: username)
            self.delegate?.cityListLoaded()
        }
    }
    
    func deleteCity(username: String, city: City, completion: @escaping (City?) -> Void) {
        let cityID = city.id
        self.ref.child(username).child(String(cityID)).removeValue()
        DispatchQueue.main.async {
            self.readCitiesIntoCityList(username: username)
            self.delegate?.cityListLoaded()
        }
    }
    
    func readCitiesIntoCityList(username: String) {
        ref.child(username).observe(.value) { snapshot in
            do {
                self.cityList.removeAll(keepingCapacity: false)
                for child in snapshot.children {
                    if let childSnapshot = child as? DataSnapshot {
                        var object: City? = nil
                        object = try childSnapshot.data(as: City.self)
                        if let object = object {
                            self.cityList.append(object)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.delegate?.cityListLoaded()
                }
            } catch {
                print("Cannot read into city list")
            }
        }
        ref.child(username).observe(.childRemoved) { snapshot in
            do {
                var object: City? = nil
                object = try snapshot.data(as: City.self)
                if let object = object {
                    self.cityList.removeAll { $0.id == object.id }
                }
                DispatchQueue.main.async {
                    self.delegate?.cityListLoaded()
                }
            } catch {
                print("Cannot remove from city list")
            }
        }
    }
    
}
