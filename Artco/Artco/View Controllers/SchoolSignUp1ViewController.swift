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
            password == passwordConfirmation else {
                // TODO : - Configure nofitication to inform user of email/password criteria
                return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                NSLog("\(error)")
                return
            }
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "SchoolFlow", bundle: nil)
                let schoolTabBarController = storyboard.instantiateViewController(withIdentifier: "SchoolTabBarController")
                schoolTabBarController.modalPresentationStyle = .fullScreen
                self.present(schoolTabBarController, animated: true, completion: nil)
                
            }
        }
    }

}
