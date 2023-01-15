//
//  SearchCityViewController.swift
//  Horus
//
//  Created by apple on 3.01.2023.
//

import UIKit

class SearchCityViewController: UIViewController {
    
    var username: String?
    
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var citySearchBar: UISearchBar!
    
    private let searchCityDataSource = SearchCityDataSource()
    private let userCityDataSource = UserCityDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchCityDataSource.delegate = self
        citySearchBar.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         if let cell = sender as? SearchCityViewCell,
            let indexPath = searchTableView.indexPath(for: cell),
            let city = cityDataSource.getCity(for: indexPath.row),
            let username = self.username,
            let _ = segue.destination as? CitiesViewController{
             datasource.pushObject(userId: username, city: city)
             self.dismiss(animated: true, completion: nil)
         }
     }
     */
}

extension SearchCityViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchCityDataSource.getNumberOfCities()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCityCell") as? SearchCityViewCell else {
            return UITableViewCell()
        }
        if let city = searchCityDataSource.getCity(for: indexPath.row) {
            cell.cityNameLabel.text = "\(city.name), \(city.region), \(city.country)"

            cell.cityNameLabel.font = cell.cityNameLabel.font.withSize(12)
        } else {
            cell.cityNameLabel.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let city = searchCityDataSource.getCity(for: indexPath.row),
           let username = self.username {
            userCityDataSource.pushCityWithCityID(username: username, city: city)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension SearchCityViewController : CityDataDelegate {
    func cityListLoaded() {
        self.searchTableView.reloadData()
    }
}

extension SearchCityViewController : SearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchCityDataSource.getListOfCities(search: searchText)
        cityListLoaded()
    }
}

