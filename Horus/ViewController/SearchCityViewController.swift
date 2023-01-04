//
//  SearchCityViewController.swift
//  Horus
//
//  Created by apple on 3.01.2023.
//

import UIKit

class SearchCityViewController: UIViewController {
    private let cityDataSource = CityDataSource()
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var citySearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "City List"
        cityDataSource.delegate = self
        
        citySearchBar.delegate = self
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

extension SearchCityViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityDataSource.getNumberOfCities()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCityCell") as? SearchCityViewCell else {
            return UITableViewCell()
        }
        if let city = cityDataSource.getCity(for: indexPath.row) {
            cell.cityNameLabel.text = "\(city.name), \(city.region), \(city.country)"

            cell.cityNameLabel.font = cell.cityNameLabel.font.withSize(12)
        } else {
            cell.cityNameLabel.text = ""
        }
        
        return cell
        
        
    }
    
}



extension SearchCityViewController : CityDataDelegate {
        func CityDataLoaded() {
            self.searchTableView.reloadData()
        }
    }


extension SearchCityViewController : SearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.cityDataSource.getListOfCities(search: searchText)
        CityDataLoaded()
        
    }
    
    
    
}

