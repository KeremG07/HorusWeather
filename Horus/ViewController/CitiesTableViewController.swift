//
//  CitiesViewController.swift
//  Horus
//
//  Created by Kerem Girenes on 27.12.2022.
//

import UIKit

class CitiesTableViewController: UITableViewController {
    
    @IBOutlet var cityListTableView: UITableView!
    
    var username: String?
    var userID = 0
    private let userCityDataSource = UserCityDataSource()
    private let weatherDataSoruce = currentWeatherMapDataSource()
    var cityList: [City] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userCityDataSource.readObject(index: 0, userId: userID)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.cityList = self.userCityDataSource.getCityList()
        }
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
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

/*extension CitiesTableViewController: UITableViewDataSource {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userCityDataSource.getCityList().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell") as? CityTableViewCell else {
            return UITableViewCell()
        }
        
        if let city = userCityDataSource.getCity(for: indexPath.row) {
            cell.cityNameLabel.text = city.name
            let weatherDegreeAndCondition = self.weatherDataSoruce.currentWeatherDegreeAndCondition
            cell.weatherDegreeLabel.text = weatherDegreeAndCondition.temp_c.description
            cell.underlayingImageView.image = UIImage(named: "sun")
            cell.overlayingImageView.image = UIImage(named: "rays")
        } else {
            cell.cityNameLabel.text = "N/A"
            cell.weatherDegreeLabel.text = "N/A"
            cell.underlayingImageView.image = UIImage(named: "sun")
            cell.overlayingImageView.image = UIImage(named: "rays")
        }
        
        return cell
    }
}*/
