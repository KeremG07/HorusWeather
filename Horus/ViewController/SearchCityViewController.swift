//
//  SearchCityViewController.swift
//  Horus
//
//  Created by apple on 3.01.2023.
//

import UIKit

class SearchCityViewController: UIViewController {
    private let cityDataSource = CityDataSource()
    private let datasource = UserCityDataSource()
    private var userId=0
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var citySearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "City List"
        cityDataSource.delegate = self
        
        citySearchBar.delegate = self
        datasource.readObject(index: 0, userId: self.userId)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         if let cell = sender as? SearchCityViewCell,
            let indexPath = searchTableView.indexPath(for: cell),
            let city = cityDataSource.getCity(for: indexPath.row),
            let detailController = segue.destination as? CitiesTableViewController{
             //detailController.cityIdentifier = city.name
             datasource.pushObject(userId: String(self.userId), city: city)
             self.dismiss(animated: true, completion: nil)
             //self.navigationController?.popViewController(animated: true) 
         }
         
     }
    

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
        //datasource.pushObject(userId: "0", city: City(id: 1, name: "0", region: "0", country: "0", lat: 0.1, lon: 0.1))
        //datasource.readObject()
        
        
        
    }
    
    
    
}

