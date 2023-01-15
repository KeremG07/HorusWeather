//
//  CollectionButtonsDataSource.swift
//  Horus
//
//  Created by Kerem Girenes on 15.01.2023.
//

import Foundation

struct CollectionButtonsDataSource {
    private let collectionButtons: [CollectionButton]
    
    init() {
        collectionButtons = [
            CollectionButton(imageName: "temperature", name: "temperature"),
            CollectionButton(imageName: "condition", name: "condition"),
            CollectionButton(imageName: "humidity", name: "humidity"),
            CollectionButton(imageName: "windspeed", name: "windspeed")
        ]
    }
    
    func getForecastButton(with name: String) -> CollectionButton? {
        return collectionButtons.first {$0.name == name}
    }
    func getNumberOfButtons() -> Int {
        return collectionButtons.count
    }
    
    func getForecastButton(for index: Int) -> CollectionButton? {
        guard index < collectionButtons.count else {
            return nil
        }
        return collectionButtons[index]
    }
    
}
