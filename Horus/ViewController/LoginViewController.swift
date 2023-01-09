//
//  LoginViewController.swift
//  Horus
//
//  Created by apple on 8.01.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    private let userDataSource = UserDataSource()

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if !username.isEmpty && !password.isEmpty {
            userDataSource.checkUsernamePasswordExists(username: username, password: password) {
                (result) in
                if result {
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let citiesTableViewController = storyboard.instantiateViewController(withIdentifier: "HorusWeather") as! CitiesTableViewController
                    citiesTableViewController.username = username
                    self.show(citiesTableViewController, sender: UIButton.self)
                } else {
                    // No match
                }
            }
        }
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
