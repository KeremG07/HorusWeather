//
//  CityAddedInfoViewController.swift
//  Horus
//
//  Created by apple on 5.01.2023.
//

import UIKit

class CityAddedInfoViewController: UIViewController {

    @IBOutlet weak var addedInfo: UILabel!
    var cityIdentifier: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        addedInfo.text = "\(cityIdentifier) has added to list"
        print(cityIdentifier)
        // Do any additional setup after loading the view.
    }
    //override func viewWillAppear(_ animated: Bool) {
    //    super.viewWillAppear(true)
     //   addedInfo.text = "\(cityIdentifier) has added to list"
    //    print(cityIdentifier)
    //}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
