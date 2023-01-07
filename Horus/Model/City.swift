//
//  City.swift
//  Horus
//
//  Created by apple on 3.01.2023.
//

import Foundation

struct City: Decodable { //decodeable yap
    let id : Int
    let name: String
    let region : String
    let country : String
    let lat : Float
    let lon : Float
    
}
