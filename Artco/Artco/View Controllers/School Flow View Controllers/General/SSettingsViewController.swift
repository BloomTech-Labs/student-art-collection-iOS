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

    @IBOutlet weak var schoolNameTextfield: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
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
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
