//
//  SchoolSignUp1ViewController.swift
//  Artco
//
//  Created by Mitchell Budge on 12/17/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit
import FirebaseAuth

class SchoolSignUp1ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func createAccountButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text,
            !email.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty,
            let passwordConfirmation = passwordConfirmationTextField.text,
            !passwordConfirmation.isEmpty,
            password == passwordConfirmation else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                if let errCode = AuthErrorCode(rawValue: error._code) {
                    let errorAlert = UIAlertController(title: "Error", message:
                        "\(errCode.errorMessage)", preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    self.present(errorAlert, animated: true, completion: nil)
                }
            }
            
            SchoolServerID.shared.serverId = Auth.auth().currentUser?.uid
            
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let schoolDetailsViewController = storyboard.instantiateViewController(withIdentifier: "SchoolDetailsViewController")
                schoolDetailsViewController.modalPresentationStyle = .fullScreen
                self.present(schoolDetailsViewController, animated: true, completion: nil)
            }
        }
    }

}
