//
//  User.swift
//  Horus
//
//  Created by apple on 5.01.2023.
//

import Foundation

struct User: Decodable, Encodable { //decodeable yap
    let id : Int
    let cityList: [City]
    
}



extension Encodable{
    var toDictionaryUser:[String:Any]?{
        guard let data = try?JSONEncoder().encode(self) else{
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options:.allowFragments) as? [String:Any]
    }
}

