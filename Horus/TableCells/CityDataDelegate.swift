//
//  CityDataDelegate.swift
//  PharmacyInfo
//
//  Created by apple on 23.11.2022.
//

import Foundation

protocol CityDataDelegate {
    func cityListLoaded()
    func cityDetailLoaded(city: City)
}

extension CityDataDelegate {
    func cityListLoaded() {}
    func cityDetailLoaded(city: City) {}
}
