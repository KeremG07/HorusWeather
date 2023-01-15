//
//  CityDetailViewController.swift
//  Horus
//
//  Created by Kerem Girenes on 27.12.2022.
//

import UIKit

class CityDetailViewController: UIViewController {
    
    var cityName: String?
    
    @IBOutlet weak var underlayingImageView: UIImageView!
    
    @IBOutlet weak var overlayingImageView: UIImageView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var weatherDegreeLabel: UILabel!
    
    @IBOutlet weak var weatherConditionLabel: UILabel!
    
    @IBOutlet weak var forecastButtonsCollectionView: UICollectionView!
    
    private let cityCurrentWeatherDataSource = CityCurrentWeatherDataSource()
    private let collectionButtonsDataSource = CollectionButtonsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cityNameLabel.text = cityName
        cityCurrentWeatherDataSource.getWeatherDataOfCity(cityName: cityName ?? "Alanya") { (weather) in
            DispatchQueue.main.async {
                self.weatherDegreeLabel.text = "\(String(Int(weather?.current.temp_c ?? 99.0)))"
                self.weatherConditionLabel.text = "\(weather?.current.condition.text ?? "Partly Cloudy")"
                self.placeWeatherImages(condition: self.weatherConditionLabel.text ?? "Partly Cloudy")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animateImages()
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
    
    func placeWeatherImages(condition: String) {
        if condition == "Partly cloudy" {
            underlayingImageView.image = UIImage(named: "sun-behind-cloud")
            overlayingImageView.image = UIImage(named: "cloud")
        } else if condition == "Sunny" {
            underlayingImageView.image = UIImage(named: "sun")
            overlayingImageView.image = UIImage(named: "rays")
        } else if condition == "Cloudy" {
            underlayingImageView.image = nil
            overlayingImageView.image = UIImage(named: "cloud")
        } else if condition == "Clear" {
            underlayingImageView.image = UIImage(named: "crescent")
            overlayingImageView.image = UIImage(named: "stars")
        } else if condition == "Moderate rain" {
            underlayingImageView.image = UIImage(named: "cloud")
            overlayingImageView.image = UIImage(named: "rain")
        } else if condition == "Light rain" {
            underlayingImageView.image = UIImage(named: "cloud")
            overlayingImageView.image = UIImage(named: "rain")
        } else if condition == "Patchy light rain" {
            underlayingImageView.image = UIImage(named: "cloud")
            overlayingImageView.image = UIImage(named: "rain")
        } else if condition == "Heavy rain" {
            underlayingImageView.image = UIImage(named: "cloud")
            overlayingImageView.image = UIImage(named: "rain")
        } else if condition == "Heavy snow" {
            underlayingImageView.image = UIImage(named: "cloud")
            overlayingImageView.image = UIImage(named: "snow")
        } else if condition == "Light snow" {
            underlayingImageView.image = UIImage(named: "cloud")
            overlayingImageView.image = UIImage(named: "snow")
        } else if condition == "Patchy light snow" {
            underlayingImageView.image = UIImage(named: "cloud")
            overlayingImageView.image = UIImage(named: "snow")
        } else if condition == "Light sleet" {
            underlayingImageView.image = UIImage(named: "cloud")
            overlayingImageView.image = UIImage(named: "snow")
        } else if condition == "Moderate or heavy sleet" {
            underlayingImageView.image = UIImage(named: "cloud")
            overlayingImageView.image = UIImage(named: "snow")
        } else if condition == "Overcast" {
            underlayingImageView.image = UIImage(named: "sun-behind-cloud")
            overlayingImageView.image = UIImage(named: "cloud")
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let cell = sender as? UICollectionViewCell,
           let cityName = self.cityName,
           let indexPath = forecastButtonsCollectionView.indexPath(for: cell),
           let forecast = collectionButtonsDataSource.getForecastButton(for: indexPath.row),
           let forecastView = segue.destination as? CityForecastViewController {
            forecastView.cityName = cityName
            forecastView.forecastType = forecast.name
        }
    }
    

}

extension CityDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionButtonsDataSource.getNumberOfButtons()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastButtonCell", for: indexPath) as? CityDetailButtonsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let forecastButton = collectionButtonsDataSource.getForecastButton(for: indexPath.row) {
            cell.forecastButtonImageView.image = UIImage(named: forecastButton.imageName)
        } else {
            cell.forecastButtonImageView.image = nil
        }
        
        return cell
    }
}
