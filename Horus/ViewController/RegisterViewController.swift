//
//  RegisterViewController.swift
//  Horus
//
//  Created by apple on 8.01.2023.
//

import UIKit
import FirebaseAuth
import Firebase


class RegisterViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signup(_ sender: UIButton) {
        guard let email = emailField.text else {return}
        guard let password = passwordField.text else { return }
        if email.isEmpty == true{
            print("Enter email")
            return
        }
        if password.isEmpty == true {
            print("Enter password")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) {
            (dataResult, error) in
            if let e = error {
                print("Error \(error?.localizedDescription)")
            }
            else {
                self.performSegue(withIdentifier: "goToApp", sender: self)
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
