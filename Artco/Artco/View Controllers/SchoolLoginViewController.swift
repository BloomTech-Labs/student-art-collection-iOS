//
//  SchoolLoginViewController.swift
//  Artco
//
//  Created by Mitchell Budge on 12/17/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit
import FirebaseUI

class SchoolLoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // TODO: - Redirect to separate view controller for creating account
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text,
            !email.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty else {
                // TODO : - Configure nofitication to inform user of email/password criteria
                return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                NSLog("\(error)")
                return
            }
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let schoolTabBarController = storyboard.instantiateViewController(withIdentifier: "SchoolTabBarController")
                schoolTabBarController.modalPresentationStyle = .fullScreen
                self.present(schoolTabBarController, animated: true, completion: nil)
                
            }
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text,
            !email.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty else {
                // TODO : - Configure nofitication to inform user of email/password criteria
                return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                // TODO: - Improve error handling
                NSLog("\(error)")
                return
            }
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let schoolTabBarController = storyboard.instantiateViewController(withIdentifier: "SchoolTabBarController")
                schoolTabBarController.modalPresentationStyle = .fullScreen
                self?.present(schoolTabBarController, animated: true, completion: nil)
            }
        }
    }
    
}
