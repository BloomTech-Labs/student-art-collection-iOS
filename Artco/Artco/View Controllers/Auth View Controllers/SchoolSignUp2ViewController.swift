//
//  SchoolSignUp2ViewController.swift
//  Artco
//
//  Created by Mitchell Budge on 1/13/20.
//  Copyright © 2020 Mitchell Budge. All rights reserved.
//

import UIKit
import Apollo

class SchoolSignUp2ViewController: UIViewController {

    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        
        
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "SchoolFlow", bundle: nil)
            let schoolTabBarController = storyboard.instantiateViewController(withIdentifier: "SchoolTabBarController")
            schoolTabBarController.modalPresentationStyle = .fullScreen
            self.present(schoolTabBarController, animated: true, completion: nil)
            
        }
    }
    
}
