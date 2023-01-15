//
//  MapViewController.swift
//  Horus
//
//  Created by apple on 6.01.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var username: String?

    @IBOutlet weak var mapView: MKMapView!
    
    private let userCityDataSource = UserCityDataSource()
    private let weatherMapDataSource = currentWeatherMapDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        userCityDataSource.readCitiesIntoCityList(username: username ?? "kerem")
        userCityDataSource.delegate = self
        mapView.delegate = self
        weatherMapDataSource.delegate = self
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotate = view.annotation
        let nameOfCity = view.annotation?.subtitle
        
        let newWindowViewController = storyboard?.instantiateViewController(withIdentifier: "cityDetail") as! CityDetailViewController
        if let nameOfCity = nameOfCity,
           let _ = annotate{
            newWindowViewController.cityName = nameOfCity ?? "N/A"
        }
        present(newWindowViewController, animated: true)
    }
    
}

extension MapViewController: WeatherDataDelegate{
    func WeatherDataLoaded() {
        let weatherList = self.weatherMapDataSource.weatherList
        for weather in weatherList {
            let annotation = MKPointAnnotation()
            annotation.coordinate = .init(latitude: CLLocationDegrees(weather.location.lat), longitude: CLLocationDegrees(weather.location.lon))
            annotation.title = "\(weather.current.temp_c) °C, \(weather.current.condition.text)"
            annotation.subtitle = weather.location.name
            self.mapView.addAnnotation(annotation)
        }
    }
}

extension MapViewController: CityDataDelegate {
    func cityListLoaded() {
        let cityList = self.userCityDataSource.getCityList()
        let coordInfo = self.userCityDataSource.getCenter()

        let region = MKCoordinateRegion(
            center: .init(
                latitude: CLLocationDegrees(coordInfo[2]),
                longitude: CLLocationDegrees(coordInfo[3])),
            latitudinalMeters: CLLocationDistance(150000*coordInfo[0]),
            longitudinalMeters: CLLocationDistance(150000*coordInfo[1]))

        self.mapView.setRegion(region, animated: true)
        for city in cityList{
            self.weatherMapDataSource.getWeather(search: city.name)
        }
    }
}
