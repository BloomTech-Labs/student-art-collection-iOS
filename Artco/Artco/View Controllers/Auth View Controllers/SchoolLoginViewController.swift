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
        emailTextField.delegate = self
        passwordTextField.delegate = self 
        
        //        DispatchQueue.main.async {
        //            let storyboard = UIStoryboard(name: "SchoolFlow", bundle: nil)
        //            let schoolTabBarController = storyboard.instantiateViewController(withIdentifier: "SchoolTabBarController")
        //            schoolTabBarController.modalPresentationStyle = .fullScreen
        //            self.present(schoolTabBarController, animated: true, completion: nil)
        //
        //        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // TODO: - Redirect to separate view controller for creating account
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text,
            !email.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty else {
                return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                if let errCode = AuthErrorCode(rawValue: error._code) {
                    if errCode == .wrongPassword {
                        let wrongPasswordAlert = UIAlertController(title: "Error", message:
                            "\(errCode.errorMessage)", preferredStyle: .alert)
                        wrongPasswordAlert.addAction(UIAlertAction(title: "Forgot password", style: .default, handler: { (action) in
                            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                                if let error = error {
                                    NSLog("\(error)")
                                    return
                                }
                                let passwordResetAlert = UIAlertController(title: "Success", message:
                                    "An email to reset your password has been sent to your inbox", preferredStyle: .alert)
                                passwordResetAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                                self?.present(passwordResetAlert, animated: true, completion: nil)
                            }
                        }))
                        wrongPasswordAlert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                        self?.present(wrongPasswordAlert, animated: true, completion: nil)
                    }
                    let errorAlert = UIAlertController(title: "Error", message:
                        "\(errCode.errorMessage)", preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    self?.present(errorAlert, animated: true, completion: nil)
                }
            }
            
            SchoolServerID.shared.firebaseId = Auth.auth().currentUser?.uid
            
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "SchoolFlow", bundle: nil)
                let schoolTabBarController = storyboard.instantiateViewController(withIdentifier: "SchoolTabBarController")
                schoolTabBarController.modalPresentationStyle = .fullScreen
                self?.present(schoolTabBarController, animated: true, completion: nil)
            }
        }
    }
    
}

extension SchoolLoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
