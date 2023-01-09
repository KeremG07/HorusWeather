//
//  MapViewController.swift
//  Horus
//
//  Created by apple on 6.01.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var userID = 0
    private let datasource = UserCityDataSource()
    private let weatherDataSource = currentWeatherMapDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        datasource.readObject(index: 0, userId: userID)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            let cityList = self.datasource.getCityList()
            var coordInfo = self.datasource.getCenter()
            let region = MKCoordinateRegion(center: .init(latitude: CLLocationDegrees(coordInfo[2]), longitude: CLLocationDegrees(coordInfo[3])), latitudinalMeters: CLLocationDistance(222000*coordInfo[0]), longitudinalMeters: CLLocationDistance(222000*coordInfo[1]))
            self.mapView.setRegion(region, animated: true)
            for city in cityList{
                //print(city.name)
                self.weatherDataSource.getWeather(search: city.name)
            }
            var counter = 0
            while cityList.count > self.weatherDataSource.weatherList.count{}
            print(self.weatherDataSource.weatherList)
            for weather in self.weatherDataSource.weatherList{
                var annotaion = MKPointAnnotation()
                annotaion.coordinate = .init(latitude: CLLocationDegrees(weather.location.lat), longitude: CLLocationDegrees(weather.location.lon))
                annotaion.title = "\(weather.current.temp_c) °C, \(weather.current.condition.text)"
                annotaion.subtitle = weather.location.name
                self.mapView.addAnnotation(annotaion)
            }
            
            
            
        }
        
        
        
        
        
        // Do any additional setup after loading the view.
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
        print(view.annotation?.title)
        print(view.annotation)
    }
}

extension MapViewController: WeatherDataDelegate{
    func WeatherDataLoaded() {
        print("weather data loaded")
    }
    
    
}
