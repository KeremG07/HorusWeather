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
    
    var registerContainerOriginalYPos: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
      
          // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        registerContainerOriginalYPos = registerContainer.frame.origin.y
        
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
