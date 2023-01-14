//
//  userCityDataSource.swift
//  Horus
//
//  Created by apple on 5.01.2023.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class UserCityDataSource: ObservableObject{
    
    private var cityList : [City] = []
    private var cityNumber = 0
    private let ref = Database.database(url: "https://horus-weather-app-8eb89-default-rtdb.europe-west1.firebasedatabase.app/").reference()
    
    func getCityList() -> [City]{
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
        //var totalLat = 0
        //var totalLon = 0
        
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
            
            //totalLon += curLon
            //totalLat += curLat
                    
        }
        
        return [(maxLat-minLat),(maxLon-minLon),Int((maxLat+minLat)/2),Int((maxLon+minLon)/2)]
        
    }
    
    func pushObject(userId:String,city:City){

            //print("push started",self.cityNumber)
            self.ref.child(userId).child(String(cityNumber)).setValue(city.toDictionary)
            cityNumber += 1
   
    }
    
    func readObject(index:Int,userId:Int){
        //print("readObject",index)
        if index == 0{
            cityList.removeAll(keepingCapacity: false)
        }
        var object:City? = nil
        ref.child(String(userId)).child(String(index))
            .observe(.value){ snapshot in do{
                object = try snapshot.data(as: City.self)
                if let object = object{
                    self.cityList.append(object)
                }
                //print(self.cityList)
                self.readObject(index: (index+1),userId: userId)
            
            }catch{
                print("Can not convert City",index)
                self.cityNumber = self.cityList.count
                
            }
                
            }
        
        
    }
    
}
