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
    
    @IBOutlet weak var registerContainer: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var registerContainerOriginalYPos: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
      
          // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        registerContainerOriginalYPos = registerContainer.frame.origin.y
        
        errorLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // If login credentials exist, skip this page
        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: "username")
        let password = defaults.string(forKey: "password")
        
        if let username = username, let _ = password {
            // Prepare main page
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let citiesViewController = storyboard.instantiateViewController(withIdentifier: "HorusWeather") as! CitiesViewController
            citiesViewController.username = username
            self.show(citiesViewController, sender: UIButton.self)
        } else {
            // Credentials do not exist
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
            
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      
      // move the register container up by the distance of keyboard height
        registerContainer.frame.origin.y = registerContainerOriginalYPos - keyboardSize.height + 20
    }

    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the register container origin to original value
        registerContainer.frame.origin.y = registerContainerOriginalYPos
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if !username.isEmpty && !password.isEmpty {
            userDataSource.checkUsernamePasswordExists(username: username, password: password) {
                (result) in
                if result {
                    self.errorLabel.isHidden = true
                    // Store credentials
                    let defaults = UserDefaults.standard
                    defaults.set(username, forKey: "username")
                    defaults.set(password, forKey: "password")
                    defaults.synchronize()
                    
                    // Prepare main page
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let citiesViewController = storyboard.instantiateViewController(withIdentifier: "HorusWeather") as! CitiesViewController
                    citiesViewController.username = username
                    self.show(citiesViewController, sender: UIButton.self)
                } else {
                    // No match
                    self.errorLabel.isHidden = false
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
        if let _ = sender as? UIButton,
           let username = usernameTextField.text,
           let _ = passwordTextField.text,
           let citiesViewController = segue.destination as? CitiesViewController {
            citiesViewController.username = username
        }
    }
    */
    

}
