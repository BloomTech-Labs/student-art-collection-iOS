//
//  SchoolSettingsViewController.swift
//  Artco
//
//  Created by Alex Rhodes on 12/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit
import FirebaseAuth

class SSettingsViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var schoolNameTextfield: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Actions
    
    // Allows school accounts to sign out and go into buyer views to see listings they created on the server
    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error)
        }
        
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginController = storyboard.instantiateViewController(withIdentifier: "RedirectViewController")
            loginController.modalPresentationStyle = .fullScreen
            self.present(loginController, animated: true, completion: nil)
        }
    }
    
    // This settings page was largely untouched, but this is where you would want to change school account information if they wanted to adjust them for any reason. See Firebase documentation for changing email/password/etc: https://firebase.google.com/docs/ios/setup/
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
