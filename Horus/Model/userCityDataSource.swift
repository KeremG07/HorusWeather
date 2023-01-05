//
//  userCityDataSource.swift
//  Horus
//
//  Created by apple on 5.01.2023.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class userCityDataSource: ObservableObject{
    
    private var cityList : [City] = []
    private var cityNumber = 0
    private let ref = Database.database(url: "https://horus-weather-app-8eb89-default-rtdb.europe-west1.firebasedatabase.app/").reference()
    
    
    
    func pushObject(userId:String,city:City){

            //print("push started",self.cityNumber)
            self.ref.child(userId).child(String(cityNumber)).setValue(city.toDictionary)
            cityNumber += 1
   
    }
    
    func readObject(index:Int,userId:Int){
        //print("readObject",index)
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
