//
//  CityForecastViewController.swift
//  Horus
//
//  Created by Kerem Girenes on 15.01.2023.
//

import UIKit

class CityForecastViewController: UIViewController {

    var cityName: String?
    var forecastType: String?
    
    @IBOutlet weak var forecastTypeLabel: UILabel!
    
    @IBOutlet weak var cityForecastTableView: UITableView!
    
    private let cityForecastDataSource = CityForecastDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        forecastTypeLabel.text = "\(forecastType?.capitalized ?? "Forecast Type")"
        cityForecastDataSource.delegate = self
        cityForecastDataSource.getForecastsIntoList(cityName: cityName ?? "Alanya")
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

extension CityForecastViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityForecastDataSource.getForecastList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell") as? CityForecastTableViewCell else {
            return UITableViewCell()
        }
        
        if let forecast = cityForecastDataSource.getForecast(for: indexPath.row) {
            cell.hourLabel.text = String(forecast.time.suffix(5))
            if forecastType == "temperature" {
                cell.valueLabel.text = "\(String(Int(forecast.temp_c))) °C"
            } else if forecastType == "humidity" {
                cell.valueLabel.text = String(forecast.humidity)
            } else if forecastType == "windspeed" {
                cell.valueLabel.text = "\(String(Int(forecast.wind_kph))) kph"
            } else if forecastType == "condition" {
                cell.valueLabel.text = forecast.condition.text
            }
            
        } else {
            cell.hourLabel.text = "N/A"
            cell.valueLabel.text = "99"
        }

        
        return cell
    }
}

extension CityForecastViewController: ForecastDataDelegate {
    func forecastDataLoaded() {
        self.cityForecastTableView.reloadData()
    }
}
