//
//  CitiesViewController.swift
//  Horus
//
//  Created by Kerem Girenes on 14.01.2023.
//

import UIKit

class CitiesViewController: UIViewController {
    
    var username: String?
    var currentLocationCityName: String?

    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var citiesTableView: UITableView!
    
    @IBOutlet weak var underlayingImageView: UIImageView!
    
    @IBOutlet weak var overlayingImageView: UIImageView!
    
    @IBOutlet weak var locationCityNameLabel: UILabel!
    
    @IBOutlet weak var locationWeatherDegreeLabel: UILabel!
    
    @IBOutlet weak var locationWeatherConditionLabel: UILabel!
    
    private let cityCurrentWeatherDataSource = CityCurrentWeatherDataSource()
    private let userCityDataSource = UserCityDataSource()
    
    let locationManager = LocationHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        welcomeLabel.text = "Welcome, \(username ?? "User")"
        
        locationManager.startUpdatingLocation()
        NotificationCenter.default.addObserver(self, selector: #selector(didGetCity), name: .didGetCity, object: nil)
        
        userCityDataSource.delegate = self
        userCityDataSource.readCitiesIntoCityList(username: username ?? "kerem")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animateImages()
    }
    
    @IBAction func logout(_ sender: Any) {
        // Forget login credentials
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "username")
        defaults.removeObject(forKey: "password")
        defaults.synchronize()
        
        // Pop to login page
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didGetCity() {
        guard let city = locationManager.city else { return }
        currentLocationCityName = city
        cityCurrentWeatherDataSource.getWeatherDataOfCity(cityName: currentLocationCityName ?? "Alanya") {
            (weather) in
            DispatchQueue.main.async {
                self.locationCityNameLabel.text = self.currentLocationCityName
                self.locationWeatherDegreeLabel.text = "\(String(Int(weather?.current.temp_c ?? 99.0)))"
                self.locationWeatherConditionLabel.text = "\(weather?.current.condition.text ?? "Sunny")"
            }
        }
        print("Current Location City: \(city)")
    }
    
    func animateImages() {
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [.repeat], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.33, animations: {
                self.underlayingImageView.transform = CGAffineTransform(translationX: 0, y: 6)
                self.overlayingImageView.transform = CGAffineTransform(translationX: 0, y: 3)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.33, animations: {
                self.underlayingImageView.transform = CGAffineTransform(translationX: 0, y: -6)
                self.overlayingImageView.transform = CGAffineTransform(translationX: 0, y: -3)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.66, relativeDuration: 0.33, animations: {
                self.underlayingImageView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.overlayingImageView.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let _ = sender as? UIButton,
           let username = self.username,
           let searchView = segue.destination as? SearchCityViewController {
            searchView.username = username
        }
        if let _ = sender as? UIButton,
           let username = self.username,
           let mapView = segue.destination as? MapViewController {
            mapView.username = username
        }
        if let cell = sender as? UITableViewCell,
           let indexPath = citiesTableView.indexPath(for: cell),
           let city = userCityDataSource.getCity(for: indexPath.row),
           let cityDetailView = segue.destination as? CityDetailViewController {
            cityDetailView.cityName = city.name
        }
    }
    
}

extension CitiesViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userCityDataSource.getCityList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell") as? CityTableViewCell else {
            return UITableViewCell()
        }
        
        if let city = userCityDataSource.getCity(for: indexPath.row) {
            cell.cityNameLabel.text = "Loading..."
            cell.weatherDegreeLabel.text = ""
            cityCurrentWeatherDataSource.getWeatherDataOfCity(cityName: city.name) { (weather) in
                DispatchQueue.main.async {
                    cell.cityNameLabel.text = "\(city.name)"
                    cell.weatherDegreeLabel.text = "\(String(Int(weather?.current.temp_c ?? 99.0)))"
                }
            }
        } else {
            cell.cityNameLabel.text = "N/A"
            cell.weatherDegreeLabel.text = "99"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let city = userCityDataSource.getCity(for: indexPath.row),
               let username = username {
                // Delete the city from the data source
                userCityDataSource.deleteCity(username: username, city: city) {
                    (result) in
                    // Delete the row from the table view
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
}

extension CitiesViewController: CityDataDelegate {
    func cityListLoaded() {
        self.citiesTableView.reloadData()
    }
}

extension Notification.Name {
    static let didGetCity = Notification.Name("didGetCity")
}
