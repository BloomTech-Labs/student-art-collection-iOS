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
    
    // MARK: - Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: - Actions and functions
    
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
            
            // Sets the Firebase id token in SchoolServerID.swift
            SchoolServerID.shared.firebaseId = Auth.auth().currentUser?.uid
            self?.setServerId()
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "SchoolFlow", bundle: nil)
                let schoolTabBarController = storyboard.instantiateViewController(withIdentifier: "SchoolTabBarController")
                schoolTabBarController.modalPresentationStyle = .fullScreen
                self?.present(schoolTabBarController, animated: true, completion: nil)
            }
        }
    }
    
    // Almost every GraphQL mutation requires an argument of either the Firebase id (captured when authenticated on Google Firebase) or the school server id (captured by this method that queries for the school's id using the Firebase id). See SchoolServerID.swift where tokens are kept.
    private func setServerId() {
           
           guard let schoolId = SchoolServerID.shared.firebaseId else { return }
           
           Network.shared.apollo
               .fetch(query: SchoolByFirebaseIdQuery(school_id: schoolId)) { [weak self] result in
                   
                   guard let self = self else {
                       return
                   }
                   
                   switch result {
                   case .success(let graphQLResult):
                       if let serverId = graphQLResult.data?.schoolBySchoolId.id {
                           SchoolServerID.shared.serverId = serverId
                        UserDefaults.standard.set(serverId, forKey: "loginID")
                                                 print(serverId)
                           print(serverId)
                       }
                       
                       if let errors = graphQLResult.errors {
                           let message = errors
                               .map { $0.localizedDescription }
                               .joined(separator: "\n")
                           self.showErrorAlert(title: "GraphQL Error(s)",
                                               message: message)
                       }
                   case .failure:
                       print("You suck this didn't work you dumb bitch")
                   }
           }
       }
       
       func showErrorAlert(title: String, message: String) {
           let alert = UIAlertController(title: title,
                                         message: message,
                                         preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default))
           self.present(alert, animated: true)
       }
    
}

// MARK: - Text field delegate methods

extension SchoolLoginViewController: UITextFieldDelegate {
    
    // Allows dismissal of text field after user entry is completed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
