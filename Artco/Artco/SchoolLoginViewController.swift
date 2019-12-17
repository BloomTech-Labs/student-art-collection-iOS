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
            print(result)
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
                  NSLog("\(error)")
                  return
              }
              print(authResult)
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
