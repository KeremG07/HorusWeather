//
//  LocationHelper.swift
//  Horus
//
//  Created by Kerem Girenes on 15.01.2023.
//

import Foundation
import CoreLocation

class LocationHelper: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var city: String?
    
    override init() {
            super.init()
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        }

        func startUpdatingLocation() {
            locationManager.startUpdatingLocation()
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                if let placemark = placemarks?.first {
                    if let city = placemark.locality {
                        self.city = city
                        NotificationCenter.default.post(name: .didGetCity, object: nil)
                    }
                }
            }
        }
}
