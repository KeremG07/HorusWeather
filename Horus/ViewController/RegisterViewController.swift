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
    private let userDataSource = UserDataSource()

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        errorLabel.isHidden = true
    }
    

    @IBAction func signup(_ sender: UIButton) {
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let repeatPassword = repeatPasswordTextField.text else { return }
        
        if repeatPassword == password
            && !username.isEmpty
            && !password.isEmpty
            && !repeatPassword.isEmpty {
            // Send Register Call to Database
            userDataSource.pushUsernamePasswordToDB(username: username, password: password)
            // Go back to Login Page
            _ = navigationController?.popViewController(animated: true)
        } else {
            errorLabel.isHidden = false
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
