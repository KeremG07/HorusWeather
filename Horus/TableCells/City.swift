//
//  City.swift
//  Horus
//
//  Created by apple on 3.01.2023.
//

import Foundation

struct City: Decodable, Encodable { //decodeable yap
    let id : Int
    let name: String
    let region : String
    let country : String
    let lat : Float
    let lon : Float
    
}



extension Encodable{
    var toDictionary:[String:Any]?{
        guard let data = try?JSONEncoder().encode(self) else{
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options:.allowFragments) as? [String:Any]
    }
}
